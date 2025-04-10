#!/bin/bash
set -ouex pipefail

CROWDSEC_REPO_URL='https://packagecloud.io/install/repositories/crowdsec/crowdsec/config_file.repo?os=rpm_any&dist=rpm_any&source=urmum'

curl -sSf "${CROWDSEC_REPO_URL}" >/etc/yum.repos.d/crowdsec.repo

dnf5 install -y yum-utils --disablerepo="crowdsec_crowdsec"
dnf5 makecache -y --disablerepo='*' --enablerepo="crowdsec_crowdsec"

# note: neovim is probably better used from distrobox or similar, but I don't want to :-)
dnf5 install --refresh -y neovim \
	htop \
	ripgrep \
	fd \
	crowdsec-firewall-bouncer-nftables

sed -i'' 's/enabled=1/enabled=0/' /etc/yum.repos.d/crowdsec.repo
