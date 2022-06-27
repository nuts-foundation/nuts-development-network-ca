#!/usr/bin/env bash
NETWORK=$1
HOST=$2
echo Generating key and certificate for $HOST to join $NETWORK
openssl ecparam -genkey -name prime256v1 -noout -out $HOST-$NETWORK.key
openssl req -new -key $HOST-$NETWORK.key -out $HOST-$NETWORK.csr -subj "/CN=${HOST}"

local_openssl_config="
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth

[alt_names]
subjectAltName = DNS:${HOST}
"
cat <<< "$local_openssl_config" > node.ext
openssl x509 -req -in $HOST-$NETWORK.csr -CA $NETWORK/ca.pem -CAkey $NETWORK/ca.key -CAcreateserial -out $HOST-$NETWORK.pem -days 365 -sha256 \
  -extfile node.ext \
  -extensions alt_names

cp $NETWORK/ca.pem truststore-$NETWORK.pem

# Generate CRL, required for some setups
# See https://github.com/nuts-foundation/nuts-development-network-ca/issues/4
touch certs-database.tmp
openssl ca -gencrl -config openssl.conf -keyfile $NETWORK/ca.key -cert $NETWORK/ca.pem -out nuts-root-ca-$NETWORK.crl
rm certs-database.tmp

rm $HOST-$NETWORK.csr
rm node.ext
