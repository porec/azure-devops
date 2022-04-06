#!/bin/bash
pwd
export PRISMA_API_URL=https://api.eu.prismacloud.io
pip3 install checkov
checkov -f Dockerfile --bc-api-key $BC_API_KEY --soft-fail

#docker run --tty --volume /$(System.DefaultWorkingDirectory)/Dockerfile:/tf/Dockerfile bridgecrew/checkov:latest --directory /tf --bc-api-key $BC_API_KEY --soft-fail