# Description

This repository contains notes about OpenSSL.

# Prerequisites

Optional: if you want to generate PGP private keys,
you can install `monkeysphere`:

    sudo apt-get install monkeysphere

# Links

    https://pagefault.blog/2019/04/22/how-to-sign-and-verify-using-openssl/

# Scripts

* [config.sh](config.sh): the configuration file. This file sets the following parameters:
  * The email address of the sender.
  * The email address of the addressee.
  * The Internet domain of the sender. This parameter is used if a certificate is used to
    authenticate a server (WEB, Mail, Database...). In this case, the _sender_ is a _server_.
  * The Internet domain of the addressee. This parameter is used if a certificate is used to
    authenticate a client (WEB, Mail, Database...). In this case, the _addressee_ is a _client_
    (that acts from within the domain).
  * The paths to the various documents that will be generated (by the script `create-certificates.sh`).
* [create-certificates.sh](create-certificates.sh): generate self-signed certificates and other documents.
  * a _public key certificate_ for a fake certification authority (PEM).
  * a _public key certificate_ for the sender (PEM).
  * a _public key certificate_ for the addressee (PEM).
  * a _PKCS #12_ archive that bundles the _public key certificate_ and the private key for the fake certification authority (P12).
  * a _PKCS #12_ archive that bundles the _public key certificate_ and the private key for the sender (P12).
  * a _PKCS #12_ archive that bundles the _public key certificate_ and the private key for the addressee (P12).
  * the private key for the fake certification authority (PEM).
  * the sender public keys (PEM).
  * the sender private key (PEM, P12 and optionally PGP).
  * the addressee public keys (PEM).
  * the addressee private key (PEM, P12 and optionally PGP).
  * and other documents.
* [sign.sh](sign.sh): "sign"/"verify".
* [sign-and-crypt.sh](sign-and-crypt.sh): "sign and crypt"/"decrypt verify".

First, edit the configuration file `config.sh` and set the required parameters.

> Please note that if you plan to use the certificates for sending emails (using
> ThunderBird, OutLook...), then you must specify the real email addresses that will
> be used (parameters `email_sender` and `email_addressee`).

# Definitions

## Public key certificate

In cryptography, a **public key certificate**, also known as a **digital
certificate** or **identity certificate**, is an electronic document used to
prove the ownership of a public key ([Wikipedia](https://en.wikipedia.org/wiki/Public_key_certificate)).

A **public key certificate** contains the following data:
* the identity of the public key certificate owner.
* the identity of the certification authority that issued the public key
  certificate (that is, the _issuer_).
* the validity period of the public key certificate.
* the public key of the public key certificate owner.
* the algorithm used to sign the public key certificate.
* a signature of the public key certificate body by the issuer's (the certification authority) private key.

> See [this link](doc/certificate.md).

## PKCS #12 archive

In cryptography, PKCS #12 defines an archive file format for storing many
cryptography objects as a single file. It is commonly used to bundle a
private key with its X.509 certificate or to bundle all the members of a
chain of trust.

> See [this link](https://en.wikipedia.org/wiki/PKCS_12).
