#!/bin/bash

set -euo pipefail

BUILD_DIR="$(mktemp -d)"

SYSBENCH_TAG="${SYSBENCH_TAG:-}"
SYSBENCH_GIT="https://github.com/akopytov/sysbench"
SYSBENCH_TAR="${SYSBENCH_TAG}.tar.gz"
SYSBENCH_URL="${SYSBENCH_GIT}/archive/refs/tags/${SYSBENCH_TAR}"
SYSBENCH_DIR="sysbench-${SYSBENCH_TAG}"

function deps() {
    yum update
    yum -y install gzip make autoconf automake libtool pkgconfig libaio-devel
}

function setup() {
    curl -fsSLO "${SYSBENCH_URL}"
    tar -xzf "${SYSBENCH_TAR}"
}

function build() {
    pushd "${SYSBENCH_DIR}"

    autoreconf -vi
    "${SHELL}" configure --without-mysql --without-pgsql
    make -j
    make install

    popd
}

function cleanup() {
    yum clean all
    rm -rf /var/cache/yum "${BUILD_DIR}"
}

function main() {
    pushd "${BUILD_DIR}"

    deps
    setup
    build

    popd
    cleanup
}

main
