#!/usr/bin/env sh
NETWORK=$1
HOST=$2

# Working directory where generated keys and certs will end up
WORKDIR=$(pwd)
# Absolute path to this script, e.g. /home/user/bin/foo.sh
# Resolve location of this script, in case it is being called from another directory
SCRIPTPATH=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTPATH")

echo Generating key and certificate for $HOST to join $NETWORK
openssl ecparam -genkey -name prime256v1 -noout -out $WORKDIR/$HOST-$NETWORK.key
openssl req -new -key $WORKDIR/$HOST-$NETWORK.key -out $WORKDIR/$HOST-$NETWORK.csr -subj "/CN=${HOST}"
openssl ecparam -genkey -name prime256v1 -noout -out $HOST-$NETWORK.key
openssl req -new -key $HOST-$NETWORK.key -out $HOST-$NETWORK.csr -subj "/CN=${HOST}"

echo "
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth

[alt_names]
subjectAltName = DNS:${HOST}
" > $WORKDIR/node.ext
openssl x509 -req -in $WORKDIR/$HOST-$NETWORK.csr -CA $SCRIPTDIR/$NETWORK/ca.pem -CAkey $SCRIPTDIR/$NETWORK/ca.key -CAcreateserial -out $WORKDIR/$HOST-$NETWORK.pem -days 365 -sha256 \
  -extfile $WORKDIR/node.ext \
  -extensions alt_names \
  -set_serial "0x`openssl rand -hex 8`"

cp $SCRIPTDIR/$NETWORK/ca.pem $WORKDIR/truststore-$NETWORK.pem

rm $WORKDIR/$HOST-$NETWORK.csr
rm $WORKDIR/node.ext
