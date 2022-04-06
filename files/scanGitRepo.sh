#!/bin/bash

#./twistcli coderepo scan --address $PC_CONSOLE -u $PCUSER -p $PCPASS $REPO_ID ./ 

#result=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?limit=1&reverse=true&sort=scanTime" | jq '.[0].vulnInfo.vulnerabilityDistribution | {critical,high,medium,low}')
#scandetails=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$REPO_ID"|jq '.[-1]')

#echo $results | jq

#critical=$(echo $result | jq -n '[inputs.critical] | add')
#high=$(echo $result | jq -n '[inputs.high] | add')
#medium=$(echo $result | jq -n '[inputs.medium] | add')
#low=$(echo $result | jq -n '[inputs.low] | add')

#if [ $critical -lt 10 ] && [ $high -lt 10 ] && [ $medium -lt 10 ] && [ $low -lt 100 ]; then
#   echo "Code Repo scan passed!"
#   exit 0
#else
#   echo "Code Repo scan failed - $critical Critical and $high High $medium Medium $low Low alerts!"
#   exit 1
#fi


##!/bin/bash -l
./twistcli coderepo scan --address $PC_CONSOLE -u $PCUSER -p $PCPASS --repository $REPO_ID ./
scandetails=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$REPO_ID"|jq '.[-1]')
scanresult=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$REPO_ID"|jq '.[-1].pass')

if [ "$scanresult" == $PRE_BUILD_GIT_SCAN_FLAG ]; then
   echo "Code Repo scan passed!"
   echo $scandetails | jq
   exit 0
else
   echo "Code Repo scan failed!"
   echo $scandetails | jq
   exit 1
fi
