#!/bin/bash

if [ "$#" -lt 3 ]; then
  echo "USAGE: $0 <CODE> <CLIENT ID> <CLIENT SECRET>"
  exit 1
fi

GRANT_TYPE="authorization_code"
REDIRECT_URI="https://localhost:9745/authresponse"

curl -X POST --data "grant_type=${GRANT_TYPE}&code=${1}&client_id=${2}&client_secret=${3}&redirect_uri=${REDIRECT_URI}" https://api.amazon.com/auth/o2/token | tee auth_token.log | python -c "import sys,json;t1=open('token.dat','w');t2=open('refresh.dat','w');x=sys.stdin.readline(); t1.write(json.loads(x)['access_token']);t2.write(json.loads(x)['refresh_token']);"
