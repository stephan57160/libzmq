#!/usr/bin/env bash
#
#   Exit if any step fails
set -e

# Use directory of current script as the working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Configuration
# See ./build.sh, for more info on supported configuration & tuning variables
export NDK_VERSION="${NDK_VERSION:-android-ndk-r25}"
export ANDROID_NDK_ROOT="${ANDROID_NDK_ROOT:-/tmp/${NDK_VERSION}}"
export MIN_SDK_VERSION=${MIN_SDK_VERSION:-21}
export ANDROID_BUILD_DIR="${ANDROID_BUILD_DIR:-${PWD}}"
export ANDROID_BUILD_CLEAN="${ANDROID_BUILD_CLEAN:-yes}"

# Path to dependencies
# If you want, you can specify the path to your own dependency clones
# before calling this script:
#    export LIBSODIUM_ROOT="<path-to-your-clone-to-LIBSODIUM>"
#    ./ci_build.sh

# Cleanup.
if [ "${ANDROID_BUILD_CLEAN}" = "yes" ] ; then
    rm -rf /tmp/android_build/
    rm -rf "${PWD}/prefix"
    rm -rf /tmp/tmp-deps
    mkdir -p /tmp/tmp-deps

    # Make sure other sub shells won't clean our job again.
    export ANDROID_BUILD_CLEAN="no"
fi

./build.sh "arm"
./build.sh "arm64"
./build.sh "x86"
./build.sh "x86_64"
