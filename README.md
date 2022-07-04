# Issuing a certificate

To issue a Nuts development network certificate use the `issuer-cert.sh` script, providing the hostname:

```shell script
    $ ./issue-cert.sh [network] my.nuts.host.nl
```

Replace `[network]` with `development` or `stable` to generate a certificate for one of those networks.

It writes the private key, certificate and the truststore in the current directory.

```
my.nuts.host.nl-development.key
my.nuts.host.nl-development.pem
truststore-development.pem
```

# Certificate Revocation List

Some reverse proxies might require a CRL when loading a trusted CA certificate.
When issuing a certificate an (empty) CRL is generated for the used network (e.g. `nuts-root-ca-development.crl`), in the current directory.