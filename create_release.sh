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
AMLTTP_REPO="https://github.com/TWOEARS/Auditory-Machine-Learning-Training-and-Testing-Pipeline"
AUDIOSTREAM_REPO="https://github.com/TWOEARS/audio-stream-server"
OPENAFE_REPO="https://github.com/TWOEARS/openAFE"
ROSAFE_REPO="https://github.com/TWOEARS/rosAFE"
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

# --- Fetch Binaural simulator and apply changes
git clone $WP1_REPO twoears-wp1
checkout twoears-wp1
git clone $SSR_REPO twoears-ssr
cd twoears-ssr
git checkout win64
cd ..
rm -rf twoears-release/BinauralSimulator/src
rm -rf twoears-release/BinauralSimulator/examples
cp -R twoears-wp1/src                   twoears-release/BinauralSimulator/src
cp -R twoears-wp1/doc/examples          twoears-release/BinauralSimulator/examples
cp -R twoears-ssr/3rdparty/win64/bin    twoears-release/BinauralSimulator/src/mex/dll
rm -rf twoears-wp1
rm -rf twoears-ssr

# --- Fetch SOFA and apply changes
git clone $SOFA_REPO twoears-sofa
checkout twoears-sofa
rm -rf twoears-release/SOFA
mkdir twoears-release/SOFA
cp -R twoears-sofa/API_MO twoears-release/SOFA/API_MO
rm -rf twoears-release/SOFA/API_MO/test
rm twoears-release/SOFA/API_MO/history.txt
rm twoears-release/SOFA/API_MO/readme.txt
rm -rf twoears-sofa

# --- Fetch Auditory front-end and apply changes
git clone $WP2_REPO twoears-wp2
checkout twoears-wp2
rm -rf twoears-release/AuditoryFrontEnd/*
cp -R twoears-wp2/src                   twoears-release/AuditoryFrontEnd/src
cp -R twoears-wp2/test                  twoears-release/AuditoryFrontEnd/test
cp twoears-wp2/AuditoryFrontEnd.xml     twoears-release/AuditoryFrontEnd/AuditoryFrontEnd.xml
cp twoears-wp2/startAuditoryFrontEnd.m  twoears-release/AuditoryFrontEnd/startAuditoryFrontEnd.m
rm -rf twoears-wp2

# --- Fetch Blackboard system and apply changes
git clone $WP3_REPO twoears-wp3
checkout twoears-wp3
rm -rf twoears-release/BlackboardSystem/*
cp -r twoears-wp3/src                   twoears-release/BlackboardSystem/src
cp twoears-wp3/BlackboardSystem.xml     twoears-release/BlackboardSystem/BlackboardSystem.xml
cp twoears-wp3/startBlackboardSystem.m  twoears-release/BlackboardSystem/startBlackboardSystem.m
rm -rf twoears-wp3

# --- Fetch Auditory Machine Learning Training and Testing Pipeline and apply changes
git clone $AMLTTP_REPO twoears-amlttp
checkout twoears-amlttp
rm -rf twoears-release/AuditoryMachineLearningTrainingTestingPipeline/src
rm -rf twoears-release/AuditoryMachineLearningTrainingTestingPipeline/third_party_software
cp -R twoears-amlttp/src twoears-release/AuditoryMachineLearningTrainingTestingPipeline/src
cp -R twoears-amlttp/third_party_software twoears-release/AuditoryMachineLearningTrainingTestingPipeline/third_party_software
cp twoears-amlttp/startAMLTTP.m  twoears-release/AuditoryMachineLearningTrainingTestingPipeline/startAMLTTP.m
cp twoears-amlttp/AMLTTP.xml twoears-release/AuditoryMachineLearningTrainingTestingPipeline/AMLTTP.xml
rm -rf twoears-amlttp

# --- Fetch Robotic platform and apply changes
rm -rf twoears-release/RoboticPlatform
# --- Fetch Audio Stream Server and apply changes 
git clone $AUDIOSTREAM_REPO twoears-audio-stream-server
checkout twoears-audio-stream-server
cp -R twoears-audio-stream-server/basc-genom3 twoears-release/RoboticPlatform/
cp -R twoears-audio-stream-server/bass-genom3 twoears-release/RoboticPlatform/
rm -rf twoears-audio-stream-server
# --- Fetch openAFE and apply
git clone $OPENAFE_REPO twoears-openafe
cp -R twoears-openafe twoears-release/RoboticPlatform/openAFE
rm twoears-release/RoboticPlatform/openAFE/.gitignore
rm -rf twoears-release/RoboticPlatform/openAFE/.git
rm -rf twoears-openafe
# --- Fetch rosAFE and apply
git clone $ROSAFE_REPO twoears-rosafe
cp -R twoears-rosafe twoears-release/RoboticPlatform/rosAFE
rm twoears-release/RoboticPlatform/rosAFE/.gitignore
rm -rf twoears-release/RoboticPlatform/rosAFE/.git
rm -rf twoears-rosafe

# --- Fetch examples and apply changes
git clone $EXAMPLES_REPO twoears-examples
checkout twoears-examples
rm -rf twoears-release/examples/*
# Include only examples with documentation
# http://docs.twoears.eu/en/latest/examples/localisation/
cp -R twoears-examples/localisation_w_and_wo_head_movements twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/localisation-details/
cp -R twoears-examples/localisation_look_at_details twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/dnn-localisation/
cp -R twoears-examples/localisation_DNNs twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/gmm-localisation/
cp -R twoears-examples/localisation_GMMs twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/train-identification/
cp -R twoears-examples/train_identification_model twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/identification/
cp -R twoears-examples/identification twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/qoe-coloration/
cp -R twoears-examples/qoe_coloration twoears-release/examples/
# http://docs.twoears.eu/en/latest/examples/qoe-localisation/
cp -R twoears-examples/qoe_localisation twoears-release/examples/
# Remove all Config.xml entries (they are only used for development)
find twoears-release/examples -type f -name "Config.xml" -exec rm -f {} \;
# Remove the corresponding startTwoEars("Config.xml") lines from the scripts
find twoears-release/examples -type f -name "*.m" -print0 | xargs -0 sed -i '/startTwoEars/d'
rm -rf twoears-examples
