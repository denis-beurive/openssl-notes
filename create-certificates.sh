#!/usr/bin/env bash

# This script generates certificates for tests.
#
# See: https://dev.mysql.com/doc/refman/5.7/en/creating-ssl-files-using-openssl.html
set -eu -o pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SOURCE="$(readlink "$SOURCE")"
done
readonly __DIR__="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

readonly USE_PEM2OPENPGP="no"

# shellcheck source=./constants.sh
. "${__DIR__}/config.sh"

# Create clean environment
rm -rf "${certificates_dir}" && \
  mkdir "${certificates_dir}" && \
  cd "${certificates_dir}"

# Create documents for the "Certification Authority".
openssl genrsa -aes128 -passout file:"${passwords_file}" 2048 > "${ca_private_key}"
openssl req -new -x509 -nodes -days 3600 \
        -key "${ca_private_key}" \
        -passin file:"${passwords_file}" \
        -out "${ca_cert}" \
        -subj "/C=FR/ST=Paris/L=Paris/O=Certification Authority/OU=IT/CN=ca.com"
openssl pkcs12 -export \
        -inkey "${ca_private_key}" \
        -passin file:"${passwords_file}" \
        -passout file:"${passwords_file}" \
        -in "${ca_cert}" \
        -out "${ca_cert_p12}"

# Create documents for the sender.
openssl req -newkey rsa:2048 -days 3600 \
        -passout file:"${passwords_file}" \
        -passin file:"${passwords_file}" \
        -nodes \
        -keyout "${sender_private_key}" \
        -out "${sender_req}" \
        -subj "/C=FR/ST=Paris/L=Paris/O=Server Corp/OU=IT/CN=${email_domain_sender}/emailAddress=${email_sender}"
openssl rsa -in "${sender_private_key}" -out "${sender_private_key}"
openssl x509 -req -in "${sender_req}" -days 3600 \
        -passin file:"${passwords_file}" \
        -CA "${ca_cert}" \
        -CAkey "${ca_private_key}" \
        -CAcreateserial \
        -out "${sender_cert}"
openssl pkcs12 -export \
        -passin file:"${passwords_file}" \
        -passout file:"${passwords_file}" \
        -inkey "${sender_private_key}" \
        -in "${sender_cert}" \
        -out "${sender_cert_p12}"

# Create documents for the client.
openssl req -newkey rsa:2048 -days 3600 \
        -passout file:"${passwords_file}" \
        -passin file:"${passwords_file}" \
        -nodes \
        -keyout "${addressee_private_key}" \
        -out "${addressee_req}" \
        -subj "/C=FR/ST=Paris/L=Paris/O=Client Corp/OU=IT/CN=${email_domain_addressee}/emailAddress=${email_addressee}"
openssl rsa -in "${addressee_private_key}" -out "${addressee_private_key}"
openssl x509 -req -in "${addressee_req}" -days 3600 \
        -CA "${ca_cert}" \
        -passin file:"${passwords_file}" \
        -CAkey "${ca_private_key}" \
        -CAcreateserial \
        -out "${addressee_cert}"
openssl pkcs12 -export \
        -passout file:"${passwords_file}" \
        -passin file:"${passwords_file}" \
        -inkey "${addressee_private_key}" \
        -in "${addressee_cert}" \
         -out "${addressee_cert_p12}"

# Verify the public key certificates.
echo "Verify the certificates"
openssl verify -CAfile "${ca_cert}" \
        "${sender_cert}" \
        "${addressee_cert}"

# Extracting the public keys.
openssl rsa -in "${ca_private_key}" -pubout \
  -passin file:"${passwords_file}" \
  -out "${sender_public_key}"
openssl rsa -in "${addressee_private_key}" -pubout \
  -passin file:"${passwords_file}" \
  -out "${addressee_public_key}"

# Check P12 files
echo
echo "-----------------------------------------------------"
openssl pkcs12 -in "${addressee_cert_p12}" -nodes -passin pass:"toto"
echo "-----------------------------------------------------"
echo
openssl pkcs12 -in "${sender_cert_p12}" -nodes -passin pass:"toto"
echo "-----------------------------------------------------"
echo

# Print the contents of the public key certificates
printf "\n======== START Certification Authority\n\n"
openssl x509 -text -noout -in "${ca_cert}"
printf "\n======== END Certification Authority\n\n"
printf "\n======== START Server\n\n"
openssl x509 -text -noout -in "${sender_cert}"
printf "\n======== END Server\n\n"
printf "\n======== START Client\n\n"
openssl x509 -text -noout -in "${addressee_cert}"
printf "\n======== END Client\n\n"

# Generate PGP keys
if [ "${USE_PEM2OPENPGP}" = "yes" ]; then
  echo "Create PGP private keys"
  pem2openpgp server_user < "${sender_private_key}" > "${sender_private_key_pgp}"
  pem2openpgp client_user < "${addressee_private_key}" > "${addressee_private_key_pgp}"
  echo "${sender_private_key_pgp}"
  echo "${addressee_private_key_pgp}"
fi

echo
echo "Certification Authority public key certificate / PKCS #12 archive:"
echo "${ca_cert}"
echo "${ca_cert_p12}"
echo
echo "Sender public key certificate / PKCS #12 archive:"
echo "${sender_cert}"
echo "${sender_cert_p12}"
echo
echo "Client public key certificate / PKCS #12 archive:"
echo "${addressee_cert}"
echo "${addressee_cert_p12}"
echo
echo "See the file \"${passwords_file}\" for the passwords!"
echo
echo "SUCCESS"
