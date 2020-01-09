#!/usr/bin/env bash
# Prerequisites:
# - define the constant __DIR__.
set -eu -o pipefail

# ------------------------------------------------------------------------
# - certificates_dir
#   Path to the directory used to store all the generated documents.
# - passwords_file
#   Path to the file that contains the passwords for the private keys.
# ------------------------------------------------------------------------
readonly certificates_dir="${__DIR__}/newcerts"
readonly passwords_file="${__DIR__}/passwords.txt"

# ------------------------------------------------------------------------
# - email_sender:
#   Email address of the sender.
# - email_domain_sender:
#   Domain of the sender email address.
# - email_addressee:
#   Email address of the addressee.
# - email_domain_addressee:
#   Domain of the addressee email address.
# ------------------------------------------------------------------------
readonly email_sender="your-address@posteo.net"
readonly email_domain_sender="posteo.net"
readonly email_addressee="your-address@gmail.com"
readonly email_domain_addressee="gmail.com"

# ------------------------------------------------------------------------
# Private keys:
# - ca_private_key
#   The "Certiciation Authority" private key.
# - sender_private_key
#   The sender private key as a PEM document.
# - sender_private_key_pgp
#   The sender private key as a PGP document.
# - addressee_private_key
#   The addressee private key as a PEM document.
# - addressee_private_key_pgp
#   The addressee private key as a PGP document.
# ------------------------------------------------------------------------
readonly ca_private_key="${certificates_dir}/ca_private_key.pem"
readonly sender_private_key="${certificates_dir}/sender_private_key.pem"
readonly sender_private_key_pgp="${certificates_dir}/sender_private_key.pgp"
readonly addressee_private_key="${certificates_dir}/addressee_private_key.pem"
readonly addressee_private_key_pgp="${certificates_dir}/addressee_private_key.pgp"

# ------------------------------------------------------------------------
# Public keys:
# - sender_public_key
#   The sender public key as a PEM document.
# - sender_public_key_pgp
#   The sender public key as a PGP document.
# - addressee_public_key
#   The addressee public key as a PEM document.
# - addressee_public_key_pgp
#   The addressee public key as a PGP document.
# ------------------------------------------------------------------------
readonly sender_public_key="${certificates_dir}/sender_public_key.pem"
readonly sender_public_key_pgp="${certificates_dir}/sender_public_key.pgp"
readonly addressee_public_key="${certificates_dir}/addressee_public_key.pem"
readonly addressee_public_key_pgp="${certificates_dir}/addressee_public_key.pgp"

# ------------------------------------------------------------------------
# Certificate Signing Request:
# - server-req
#   Certificate Signing Request used to generate the certificate for the
#   sender.
# -addressee_req
#   Certificate Signing Request used to generate the certificate for the
#   addressee.
# ------------------------------------------------------------------------
readonly sender_req="${certificates_dir}/sender_req.pem"
readonly addressee_req="${certificates_dir}/addressee_req.pem"

# ------------------------------------------------------------------------
# Cerificates:
# - ca_cert
#   This is the public key certificate for the "Certification Authority".
# - sender_cert
#   This is the public key certificate for the sender.
# - addressee_cert
#   This is the public key certificate for the addressee.
# ------------------------------------------------------------------------
readonly ca_cert="${certificates_dir}/ca_cert.pem"
readonly ca_cert_p12="${certificates_dir}/ca_cert.p12"
readonly sender_cert="${certificates_dir}/sender_cert.pem"
readonly sender_cert_p12="${certificates_dir}/sender_cert.p12"
readonly addressee_cert="${certificates_dir}/addressee_cert.pem"
readonly addressee_cert_p12="${certificates_dir}/addressee_cert.p12"
