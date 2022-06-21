# Issue certificate using Docker

To issue a Nuts development network certificate use the `issuer-cert-docker.sh` script, providing the hostname:

```shell script
    $ ./issue-cert-docker.sh [network] my.nuts.host.nl
```

Replace `[network]` with `development` or `stable` to generate a certificate for one of those networks.

It writes the private key and certificate in the `issued-certificates` directory.

Note: to generate a wildcard certificate, put the host name in double quotes.

# Issue certificate without Docker

If you don't want to use Docker you can use the OpenSSL script directly:

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
