if [[ $OSTYPE == msys ]]; then
  echo Script does not work on GitBash/Cygwin!
  exit 1
fi

echo Generating development network root CA
openssl ecparam -genkey -name prime256v1 -noout -out ca.key
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1825 -out ca.pem -subj "/CN=Nuts Development Network Root CA"
