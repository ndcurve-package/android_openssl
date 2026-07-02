
 # INPUTS

 # If in doubt check Qt Creator -> Projects -> Build -> CMAKE Variables
 # ANDROID_NATIVE_API_LEVEL 28                  Android 9 (API 28) to 15 (API 35) Note: https://doc.qt.io/qt-6/android.html

 source $HOME/QtProjects/Ndcurve/bin/android/config


 ANDROID_NDK=$ANDROID_NDK_ROOT
 ANDROID_API_LEVEL=$ANDROID_SDK_API_LEVEL
 SSL_SUFFIX=_4

 # Android 16 KB Page Alignment. NDK 27.2 by default doesn't do this. This may be removed if we switch to NDK 28 as it does compile by default.
#  export LDFLAGS="-Wl,-z,max-page-size=16384"

#  OPEN_SSL_VERSION=3.1.0
 OPEN_SSL_VERSION=4.0.1
 # ----------------------------------------------------------------------------

 export ANDROID_NDK_ROOT=$ANDROID_NDK
 export PATH="$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin":$PATH

 rm -rf latest
 rm -rf build


function build() {
 rm -rf "latest/$ARCH" && mkdir -p "latest/$ARCH"
 rm -rf build && mkdir -p build && cd build
 ../openssl-openssl-${OPEN_SSL_VERSION}/Configure shared android-$ARCH -D__ANDROID_API__=$ANDROID_API_LEVEL
 make -j$(nproc) SHLIB_VERSION_NUMBER= SHLIB_EXT=$SSL_SUFFIX.so build_libs
 cp libcrypto.a "../latest/$ARCH/libcrypto$SSL_SUFFIX.a"
 cp libssl.a "../latest/$ARCH/libssl$SSL_SUFFIX.a"
 cp libcrypto.so "../latest/$ARCH/libcrypto$SSL_SUFFIX.so"
 cp libssl.so "../latest/$ARCH/libssl$SSL_SUFFIX.so"
 cd ..
}

function build_noasm() {
 rm -rf "latest/no-asm/$ARCH" && mkdir -p "latest/no-asm/$ARCH"
 rm -rf build && mkdir -p build && cd build
 ../openssl-openssl-${OPEN_SSL_VERSION}/Configure shared android-$ARCH -D__ANDROID_API__=$ANDROID_API_LEVEL no-asm
 make -j$(nproc) SHLIB_VERSION_NUMBER= SHLIB_EXT=$SSL_SUFFIX.so build_libs
 cp libcrypto.a "../latest/no-asm/$ARCH/libcrypto$SSL_SUFFIX.a"
 cp libssl.a "../latest/no-asm/$ARCH/libssl$SSL_SUFFIX.a"
 cp libcrypto.so "../latest/no-asm/$ARCH/libcrypto$SSL_SUFFIX.so"
 cp libssl.so "../latest/no-asm/$ARCH/libssl$SSL_SUFFIX.so"
 cd ..
}


ARCH=arm64
build

ARCH=arm
build

ARCH=x86
build

ARCH=x86_64
build



ARCH=arm64
build_noasm

ARCH=arm
build_noasm

ARCH=x86
build_noasm

ARCH=x86_64
build_noasm

mv latest ndcurve

echo "Openssl Compilation Completed."

