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

# --- Get actual release repo
git clone $RELEASE_REPO twoears-release

# --- Fetch Main and apply changes
git clone $MAIN_REPO twoears-main
rm -rf twoears-release/Tools
cp twoears-main/LICENSE         twoears-release/LICENSE
cp twoears-main/README.md       twoears-release/README.md
cp twoears-main/startTwoEars.m  twoears-release/startTwoEars.m
cp -R twoears-main/Tools        twoears-release/Tools
rm -rf twoears-main

# --- Fetch Binaural simulator and apply changes
git clone $WP1_REPO twoears-wp1
git clone $SSR_REPO twoears-ssr
cd twoears-ssr
git checkout win64
cd ..
git clone $SOFA_REPO twoears-sofa
rm -rf twoears-release/BinauralSimulator/src
rm -rf twoears-release/BinauralSimulator/examples
cp -R twoears-wp1/src                   twoears-release/BinauralSimulator/src
cp -R twoears-wp1/doc/examples          twoears-release/BinauralSimulator/examples
cp -R twoears-ssr/3rdparty/win64/bin    twoears-release/BinauralSimulator/src/mex/dll
cp -R twoears-sofa/API_MO               twoears-release/BinauralSimulator/src/sofa
rm -rf twoears-release/BinauralSimulator/src/sofa/converters
rm -rf twoears-release/BinauralSimulator/src/sofa/demos
rm -rf twoears-release/BinauralSimulator/src/sofa/test
rm twoears-release/BinauralSimulator/src/sofa/history.txt
rm twoears-release/BinauralSimulator/src/sofa/readme.txt
rm -rf twoears-wp1
rm -rf twoears-ssr
rm -rf twoears-sofa

# --- Fetch Auditory front-end and apply changes
git clone $WP2_REPO twoears-wp2
rm -rf twoears-release/AuditoryFrontEnd/*
cp -R twoears-wp2/src                   twoears-release/AuditoryFrontEnd/src
cp -R twoears-wp2/test                  twoears-release/AuditoryFrontEnd/test
cp twoears-wp2/AuditoryFrontEnd.xml     twoears-release/AuditoryFrontEnd/AuditoryFrontEnd.xml
cp twoears-wp2/startAuditoryFrontEnd.m  twoears-release/AuditoryFrontEnd/startAuditoryFrontEnd.m
rm -rf twoears-wp2

# --- Fetch Blackboard system and apply changes
git clone $WP3_REPO twoears-wp3
rm -rf twoears-release/BlackboardSystem/*
cp -r twoears-wp3/src                   twoears-release/BlackboardSystem/src
cp twoears-wp3/BlackboardSystem.xml     twoears-release/BlackboardSystem/BlackboardSystem.xml
cp twoears-wp3/startBlackboardSystem.m  twoears-release/BlackboardSystem/startBlackboardSystem.m
rm -rf twoears-wp3

# --- Fetch Identification-Training-Pipeline and apply changes
git clone $IDTRAIN_REPO twoears-id-train
rm -rf twoears-release/IdentificationTraining/src
rm -rf twoears-release/IdentificationTraining/third_party_software
cp -R twoears-id-train/src                      twoears-release/IdentificationTraining/src
cp -R twoears-id-train/third_party_software     twoears-release/IdentificationTraining/third_party_software
cp twoears-id-train/IdentificationTraining.xml  twoears-release/IdentificationTraining/IdentificationTraining.xml
# FIXME: startIdentificationTraining from twoears-id-train cannot be used at the
# moment
rm -rf twoears-id-train

# --- Fetch Robotic platform and apply changes
# FIXME: this has to be updated

# --- Fetch examples and apply changes
git clone $EXAMPLES_REPO twoears-examples
rm -rf twoears-release/examples/*
cp -R twoears-examples/* twoears-release/examples/
rm twoears-release/examples/README.md
rm -rf twoears-examples
