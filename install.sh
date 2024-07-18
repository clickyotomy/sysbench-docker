#!/bin/bash

set -euo pipefail

INSTALL_BASE="https://packagecloud.io/install/repositories/akopytov/sysbench"

function install_curl() {
    apt-get update
    apt-get install -y curl
}

function install_sysbench() {
    curl -fsSLO "${INSTALL_BASE}/script.deb.sh" | "${SHELL}"
    apt-get install -y sysbench
}

function cleanup() {
    apt-get clean autoclean
    apt-get autoremove --yes
    rm -rf /var/lib/apt/lists/*
}

function main() {
    install_curl
    install_sysbench
    cleanup
}

main
