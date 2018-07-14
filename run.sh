#!/bin/bash

cd /home/crowdai/
mkdir -p output
ls -lha

echo "================================================================================"
echo "Beginning execution of random_agent.py"
echo "================================================================================"
ls .
CROWDAI_AGENT_NAME=$CROWDAI_AGENT_NAME \
/home/crowdai/random_agent.py
