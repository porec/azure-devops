#!/bin/bash
pwd
export PRISMA_API_URL=https://api.eu.prismacloud.io
pip3 install checkov
checkov -d deploy --bc-api-key $BC_API_KEY --soft-fail
