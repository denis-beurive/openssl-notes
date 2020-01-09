#!/usr/bin/env bash
set -eu -o pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  SOURCE="$(readlink "$SOURCE")"
done

readonly __DIR__="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# shellcheck source=./constants.sh
. "${__DIR__}/config.sh"

# -----------------------------------------------------------------------------
# Configuration
#
# The value of $ACTION can be:
# - "sign-only"
# - "sign-and-crypt"
# -----------------------------------------------------------------------------

readonly ACTION="sign-and-crypt"
readonly input_file="${__DIR__}/input.txt"
readonly signed_encrypted_file="${__DIR__}/signed-encrypted.txt"
readonly verified_signed_encrypted_file="${__DIR__}/verified-signed-encrypted.txt"

# Make sure that the files exists

if [ ! -f "${passwords_file}" ]; then
  echo "File \"${passwords_file}\" does not exist!"
  exit 1
fi

if [ ! -f "${input_file}" ]; then
  echo "File \"${input_file}\" does not exist!"
  exit 1
fi

if [ ! -f "${ca_cert}" ]; then
  echo "File \"${ca_cert}\" does not exist!"
  exit 1
fi

if [ ! -f "${sender_cert}" ]; then
  echo "File \"${sender_cert}\" does not exist!"
  exit 1
fi

if [ ! -f "${addressee_cert}" ]; then
  echo "File \"${addressee_cert}\" does not exist!"
  exit 1
fi

if [ ! -f "${sender_private_key}" ]; then
  echo "File \"${sender_private_key}\" does not exist!"
  exit 1
fi

if [ ! -f "${addressee_private_key}" ]; then
  echo "File \"${addressee_private_key}\" does not exist!"
  exit 1
fi

# Verify the certificates
echo "Verify the certificates"
openssl verify -CAfile "${ca_cert}" "${sender_cert}" "${sender_cert}"
if [ $? -ne 0 ]; then
    echo "There is a problem with the certificates!"
    exit 1
fi
echo

# Sign and crypt
echo "Sign and crypt:"
printf "input:  %s\noutput: %s\n" "${input_file}" "${signed_encrypted_file}"
openssl smime \
    -sign \
    -passin "file:${passwords_file}" \
    -in "${input_file}" \
    -nodetach \
    -signer "${sender_cert}" \
    -inkey "${sender_private_key}" | \
    openssl smime \
        -encrypt \
        -des3 \
        -out "${signed_encrypted_file}" \
        "${addressee_cert}"
echo

# Decrypt and verify the signature
echo "Verify the encrypted signature:"
printf "input:  %s\noutput: %s\n" "${signed_encrypted_file}" "${verified_signed_encrypted_file}"
openssl smime \
    -decrypt \
    -des3 \
    -recip "${addressee_cert}" \
    -inkey "${addressee_private_key}" \
    -in "${signed_encrypted_file}" \
    "${addressee_cert}" | \
    openssl smime \
        -verify \
        -CAfile "${ca_cert}" \
        -signer "${sender_cert}" \
        -out "${verified_signed_encrypted_file}"
echo

printf "input:                  %s\n" "${input_file}"
printf "signed and encrypted:   %s\n" "${signed_encrypted_file}"
printf "decrypted and verified: %s\n" "${verified_signed_encrypted_file}"

echo
echo
echo
echo
echo


