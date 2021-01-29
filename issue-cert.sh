HOST=$1
echo Generating key and certificate for $HOST
openssl ecparam -genkey -name prime256v1 -noout -out $HOST.key
openssl req -new -key $HOST.key -out $HOST.csr -subj "/CN=${HOST}"

local_openssl_config="
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth

[alt_names]
subjectAltName = DNS:${HOST}
"
cat <<< "$local_openssl_config" > node.ext
openssl x509 -req -in $HOST.csr -CA ca/ca.pem -CAkey ca/ca.key -CAcreateserial -out $HOST.pem -days 365 -sha256 \
  -extfile node.ext \
  -extensions alt_names

rm $HOST.csr
rm node.ext
