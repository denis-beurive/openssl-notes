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
# -----------------------------------------------------------------------------

readonly input_file="${__DIR__}/input.txt"
readonly signed_file="${__DIR__}/signed.txt"
readonly verified_signed_file="${__DIR__}/verified-signed.txt"

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

if [ ! -f "${sender_private_key}" ]; then
  echo "File \"${sender_private_key}\" does not exist!"
  exit 1
fi

if [ ! -f "${input_file}" ]; then
  echo "File \"${input_file}\" does not exist!"
  exit 1
fi

# Verify the certificates
echo "Verify the certificates"
openssl verify -CAfile "${ca_cert}" "${sender_cert}"
if [ $? -ne 0 ]; then
    echo "The certificate \"${sender_cert}\" is not valid!"
    exit 1
fi
echo

# Sign
echo "Sign only"
printf "input:  %s\noutput: %s\n" "${input_file}" "${signed_file}"
openssl smime \
    -sign \
    -passin "file:${passwords_file}" \
    -text \
    -nodetach \
    -certfile "${sender_cert}" \
    -in "${input_file}" \
    -out "${signed_file}" \
    -signer "${sender_cert}" \
    -inkey "${sender_private_key}"
if [ $? -ne 0 ]; then
    echo "Signature failed!"
    exit 1
fi
echo

# Verify the signature
printf "Verify the signature:\n"
printf "input:  %s\noutput: %s\n" "${signed_file}" "${verified_signed_file}"
openssl smime \
    -verify \
    -in "${signed_file}" \
    -CAfile "${ca_cert}" \
    -signer "${sender_cert}" \
    -out "${verified_signed_file}"
if [ $? -ne 0 ]; then
    echo "Verification failed!"
    exit 1
fi

echo
printf "input:    %s\n" "${input_file}"
printf "signed:   %s\n" "${signed_file}"
printf "verified: %s\n" "${verified_signed_file}"
