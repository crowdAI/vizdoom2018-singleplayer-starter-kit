#!/bin/bash

cd /home/crowdai/
mkdir -p output
ls -lha

echo "================================================================================"
echo "Beginning execution of mock.py"
echo "================================================================================"
/home/crowdai/mock.py > output/mock_output.txt
