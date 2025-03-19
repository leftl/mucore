#!/bin/bash
set -ouex pipefail

CROWDSEC_REPO_URL='https://packagecloud.io/install/repositories/crowdsec/crowdsec/config_file.repo?os=rpm_any&dist=rpm_any&source=urmum'

curl -sSf "${CROWDSEC_REPO_URL}" >/etc/yum.repos.d/crowdsec.repo

# note: neovim is probably better used from distrobox or similar, but I don't want to :-)
dnf5 install --refresh -y neovim \
	htop \
       dnf5-plugins \
       crowdsec-firewall-bouncer-nftables

dnf5 config-manager setopt crowdsec\*.enabled=0
