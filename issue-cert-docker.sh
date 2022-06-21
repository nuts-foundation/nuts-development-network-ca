#!/bin/sh
NETWORK=$1
HOST=$2
echo Generating key and certificate for $HOST to join $NETWORK

docker run --rm \
  -v $(pwd)/issued-certificates:/work \
  -v $(pwd):/scripts/:rw \
  -w /work \
  --entrypoint=/bin/sh \
  alpine/openssl -c "/scripts/issue-cert.sh $NETWORK $HOST"
