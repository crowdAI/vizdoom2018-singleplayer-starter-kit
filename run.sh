#!/bin/bash

cd /home/crowdai/
mkdir -p output
ls -lha

echo "================================================================================"
echo "Beginning execution of mock.py"
echo "================================================================================"
CROWDAI_AGENT_NAME=$CROWDAI_AGENT_NAME \
CROWDAI_GAME_SERVER=$CROWDAI_GAME_SERVER \
/home/crowdai/mock.py > output/mock_output.txt
