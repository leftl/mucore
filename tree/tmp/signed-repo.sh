#!/bin/bash
set -ouex pipefail

mkdir -p /etc/containers
mkdir -p /etc/pki/containers
mkdir -p /etc/containers/registries.d
mkdir -p /usr/etc/containers

if [ -f /usr/etc/containers/policy.json ]; then
	echo "Copying config from /usr/etc"
	cp /usr/etc/containers/policy.json /etc/containers/policy.json
fi

jq '.transports.docker |=. + {
   "ghcr.io/leftl/mucore": [
    {
        "type": "sigstoreSigned",
        "keyPath": "/etc/pki/containers/mucore.pub",
        "signedIdentity": {
            "type": "matchRepository"
        }
    }
]}' /etc/containers/policy.json > /tmp/policy.json

cp /tmp/policy.json /etc/containers/policy.json
cp /etc/containers/policy.json /usr/etc/containers/policy.json

cp /tmp/signing/cosign.pub /etc/pki/containers/mucore.pub
