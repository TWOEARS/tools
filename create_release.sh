#!/bin/bash
# This script creates everything needed for a Two!Ears Auditory model release
#
# It fetches all the single repositories, creates the desired folder structure
# of the release and copies all the needed data into this structure

RELEASE_REPO="https://github.com/TWOEARS/TwoEars"
# Development repos
MAIN_REPO="https://github.com/TWOEARS/main"
WP1_REPO="https://github.com/TWOEARS/binaural-simulator"
SSR_REPO="https://github.com/TWOEARS/twoears-ssr"
SOFA_REPO="https://github.com/TWOEARS/SOFA"
WP2_REPO="https://github.com/TWOEARS/auditory-front-end"
WP3_REPO="https://github.com/TWOEARS/blackboard-system"
IDTRAIN_REPO="https://github.com/TWOEARS/identification-training-pipeline"
EXAMPLES_REPO="https://github.com/TWOEARS/examples"
# Version of development repos to use
VERSION="master"
function checkout {
    cd $1
    git checkout $VERSION
    cd -
}

# --- Get actual release repo
rm -rf twoears-release
git clone $RELEASE_REPO twoears-release

# --- Fetch Main and apply changes
git clone $MAIN_REPO twoears-main
checkout twoears-main
rm -rf twoears-release/Tools
cp twoears-main/LICENSE         twoears-release/LICENSE
cp twoears-main/README.md       twoears-release/README.md
cp twoears-main/startTwoEars.m  twoears-release/startTwoEars.m
cp -R twoears-main/Tools        twoears-release/Tools
rm -rf twoears-main

# --- Fetch Binaural simulator and apply changes (stay with 1.2)
#git clone $WP1_REPO twoears-wp1
#checkout twoears-wp1
#git clone $SSR_REPO twoears-ssr
#cd twoears-ssr
#git checkout win64
#cd ..
#rm -rf twoears-release/BinauralSimulator/src
#rm -rf twoears-release/BinauralSimulator/examples
#cp -R twoears-wp1/src                   twoears-release/BinauralSimulator/src
#cp -R twoears-wp1/doc/examples          twoears-release/BinauralSimulator/examples
#cp -R twoears-ssr/3rdparty/win64/bin    twoears-release/BinauralSimulator/src/mex/dll
#rm -rf twoears-wp1
#rm -rf twoears-ssr
# Update database version
sed -i -e 's/master/v1.3/' twoears-release/BinauralSimulator/src/+xml/dbURL.m

# --- Fetch SOFA and apply changes (stay with 1.2)
#git clone $SOFA_REPO twoears-sofa
#checkout twoears-sofa
#rm -rf twoears-release/SOFA
#mkdir twoears-release/SOFA
#cp -R twoears-sofa/API_MO twoears-release/SOFA/API_MO
#rm -rf twoears-release/SOFA/API_MO/test
#rm twoears-release/SOFA/API_MO/history.txt
#rm twoears-release/SOFA/API_MO/readme.txt
#rm -rf twoears-sofa

# --- Fetch Auditory front-end and apply changes
#git clone $WP2_REPO twoears-wp2
#checkout twoears-wp2
#rm -rf twoears-release/AuditoryFrontEnd/*
#cp -R twoears-wp2/src                   twoears-release/AuditoryFrontEnd/src
#cp -R twoears-wp2/test                  twoears-release/AuditoryFrontEnd/test
#cp twoears-wp2/AuditoryFrontEnd.xml     twoears-release/AuditoryFrontEnd/AuditoryFrontEnd.xml
#cp twoears-wp2/startAuditoryFrontEnd.m  twoears-release/AuditoryFrontEnd/startAuditoryFrontEnd.m
#rm -rf twoears-wp2

# --- Fetch Blackboard system and apply changes
git clone $WP3_REPO twoears-wp3
checkout twoears-wp3
cp twoears-wp3/src/knowledge_sources/ConfusionKS.m twoears-release/BlackboardSystem/src/knowledge_sources/
cp twoears-wp3/src/knowledge_sources/ConfusionSolvingKS.m twoears-release/BlackboardSystem/src/knowledge_sources/
cp twoears-wp3/src/knowledge_sources/DnnLocationKS.m twoears-release/BlackboardSystem/src/knowledge_sources/
cp twoears-wp3/src/knowledge_sources/ItdLocationKS.m twoears-release/BlackboardSystem/src/knowledge_sources/
cp twoears-wp3/src/knowledge_sources/GmmLocationKS.m twoears-release/BlackboardSystem/src/knowledge_sources/
cp twoears-wp3/startBlackboardSystem.m  twoears-release/BlackboardSystem/startBlackboardSystem.m

#rm -rf twoears-release/BlackboardSystem/*
#cp -r twoears-wp3/src                   twoears-release/BlackboardSystem/src
#cp twoears-wp3/BlackboardSystem.xml     twoears-release/BlackboardSystem/BlackboardSystem.xml
rm -rf twoears-wp3

# --- Fetch Identification-Training-Pipeline and apply changes
#git clone $IDTRAIN_REPO twoears-id-train
#checkout twoears-id-train
#rm -rf twoears-release/IdentificationTraining/src
#rm -rf twoears-release/IdentificationTraining/third_party_software
#cp -R twoears-id-train/src                      twoears-release/IdentificationTraining/src
#cp -R twoears-id-train/third_party_software     twoears-release/IdentificationTraining/third_party_software
#cp twoears-id-train/IdentificationTraining.xml  twoears-release/IdentificationTraining/IdentificationTraining.xml
## FIXME: startIdentificationTraining from twoears-id-train cannot be used at the
## moment
#rm -rf twoears-id-train

# --- Fetch Robotic platform and apply changes
# FIXME: this has to be updated

# --- Fetch examples and apply changes
git clone $EXAMPLES_REPO twoears-examples
checkout twoears-examples
rm -rf twoears-release/examples/qoe_localisation
rm -rf twoears-release/examples/localisation_DNNs
cp -R twoears-examples/qoe_localisation twoears-release/examples/
cp -R twoears-examples/localisation_DNNs twoears-release/examples/
#rm -rf twoears-release/examples/*
#cp -R twoears-examples/* twoears-release/examples/
#rm twoears-release/examples/README.md
# Remove all Config.xml entries (they are only used for development)
find twoears-release/examples -type f -name "Config.xml" -exec rm -f {} \;
# Remove the corresponding startTwoEars("Config.xml") lines from the scripts
find twoears-release/examples -type f -name "*.m" -print0 | xargs -0 sed -i '/startTwoEars/d'
rm -rf twoears-examples

# vim: set textwidth=3000:
