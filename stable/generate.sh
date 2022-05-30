echo Generating stable CA
openssl ecparam -genkey -name prime256v1 -noout -out ca.key
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1825 -out ca.pem -subj "/CN=Nuts Stable Development Network Root CA"
