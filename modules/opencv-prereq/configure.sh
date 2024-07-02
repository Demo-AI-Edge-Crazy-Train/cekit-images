#!/bin/bash
set -e

SCRIPT_DIR=$(dirname $0)
ARTIFACTS_DIR=${SCRIPT_DIR}/artifacts

chown -R $USER:root $SCRIPT_DIR
chmod -R ug+rwX $SCRIPT_DIR

pushd ${ARTIFACTS_DIR}
cp -pr * /
popd

createrepo /usr/local/src/opencv/$(uname -m)/

dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf -y install 'dnf-command(config-manager)'
dnf -y config-manager --enable fedora-cisco-openh264
dnf -y install ffmpeg
dnf -y install --disablerepo='*' --enablerepo="rpmfusion-free" --enablerepo="rpmfusion-free-updates" libavcodec-freeworld
