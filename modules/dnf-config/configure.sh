#!/bin/sh
# Configure module
set -e

cat >> /etc/dnf/dnf.conf <<EOF
install_weak_deps=False
EOF
