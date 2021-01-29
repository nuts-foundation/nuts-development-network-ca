echo Generating root CA
openssl ecparam -genkey -name prime256v1 -noout -out ca.key
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1095 -out ca.pem -subj "/CN=Nuts Development Network Root CA"
