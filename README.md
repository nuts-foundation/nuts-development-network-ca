# Issuing a certificate

To issue a Nuts development/stable network certificate use the `issue-cert.sh` script:

```shell script
    $ ./issue-cert.sh network hostname...
```

Replace `network` with `development` or `stable` to generate a certificate for one of those networks.

Fill in one or more `hostname` to list as Subject Alternative Name on the certificate.

Example:
```shell script
$ ./issue-cert.sh development my.nuts.host.nl my-other.nuts.host.nl
```
Writes the private key, certificate, and the truststore in the current directory.
```
my.nuts.host.nl-development.key
my.nuts.host.nl-development.pem
truststore-development.pem
```

# Certificate Revocation List

Some reverse proxies might require a CRL when loading a trusted CA certificate.
When issuing a certificate an (empty) CRL is generated for the used network (e.g. `nuts-root-ca-development.crl`), in the current directory.