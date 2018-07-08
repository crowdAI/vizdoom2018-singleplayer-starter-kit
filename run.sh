#!/bin/bash

cd /home/crowdai/
mkdir -p output
ls -lha

echo "================================================================================"
echo "Beginning execution of mock.py"
echo "================================================================================"
ls .
CROWDAI_AGENT_NAME=$CROWDAI_AGENT_NAME \
/home/crowdai/mock.py
