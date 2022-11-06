#!/bin/bash

if [[ $OSTYPE == msys ]]; then
  echo Script does not work on GitBash/Cygwin!
  exit 1
fi

CONFIG="
[req]
distinguished_name=dn
[ dn ]
[ ext ]
basicConstraints=CA:TRUE,pathlen:0
"

echo Generating stable network root CA
openssl ecparam -genkey -name prime256v1 -noout -out ca.key
openssl req -config <(echo "$CONFIG") -extensions ext -x509 -new -nodes -key ca.key -sha256 -days 1825 -out ca.pem -subj "/CN=Nuts Stable Development Network Root CA"
