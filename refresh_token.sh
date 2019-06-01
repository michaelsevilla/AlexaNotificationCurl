#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "USAGE: $0 <CLIENT ID> <CLIENT SECRET>"
  exit 1
fi

REFRESH=`cat refresh.dat`
GRANT_TYPE="refresh_token"
REDIRECT_URI="https://localhost:9745/authresponse"

curl -X POST --data "grant_type=${GRANT_TYPE}&refresh_token=${REFRESH}&client_id=${1}&client_secret=${2}&redirect_uri=${REDIRECT_URI}" https://api.amazon.com/auth/o2/token | tee refresh_token.log | python -c "import sys,json;t1=open('token.dat','w');t2=open('refresh.dat','w');x=sys.stdin.readline(); t1.write(json.loads(x)['access_token']);t2.write(json.loads(x)['refresh_token']);"
