#!/bin/bash

set -e

platform=android-24
toolchain_version=clang3.6

test_ndk_build() {
    local abi="${1}"
    local outdir="out/ndk_${abi}"

    rm -rf "${outdir}"

    ndk-build \
        NDK_LIBS_OUT="${outdir}/libs" \
        NDK_OUT="${outdir}/obj" \
        NDK_PROJECT_PATH=. \
        NDK_TOOLCHAIN_VERSION="${toolchain_version}" \
        NDK_APPLICATION_MK=Application.mk \
        APP_BUILD_SCRIPT=Android.mk \
        APP_STL=c++_static \
        APP_PLATFORM="${platform}" \
        APP_ABI="${abi}"
}

test_cmake() {
    local abi="${1}"
    local toolchain="${2}"
    local outdir="out/cmake_${abi}"

    rm -rf "${outdir}"
    mkdir -p "${outdir}"

    pushd "${outdir}"
    cmake ../.. \
        -DCMAKE_TOOLCHAIN_FILE=android.toolchain.cmake \
        -DANDROID_ABI="${abi}" \
        -DANDROID_TOOLCHAIN_NAME="${toolchain}-${toolchain_version}" \
        -DANDROID_STL=c++_static \
        -DANDROID_NATIVE_API_LEVEL="${platform}"
    make
    popd
}

test_ndk_build armeabi
test_ndk_build armeabi-v7a
test_ndk_build arm64-v8a
test_ndk_build x86
test_ndk_build x86_64

test_cmake armeabi arm-linux-androideabi
test_cmake armeabi-v7a arm-linux-androideabi
test_cmake arm64-v8a aarch64-linux-android
test_cmake x86 x86
test_cmake x86_64 x86_64
