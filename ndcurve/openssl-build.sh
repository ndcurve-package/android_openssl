
 # INPUTS

 # If in doubt check Qt Creator -> Projects -> Build -> CMAKE Variables
 # ANDROID_NATIVE_API_LEVEL 23                  For Android 6.0 or later (API level 23 or higher) Note: https://doc.qt.io/qt-6/android.html
 # ANDROID_NDK /home/muneer/.Installation/android-sdk-linux/ndk/25.1.8937393
 ANDROID_NDK="/home/muneer/.Installation/android-sdk-linux/ndk/25.1.8937393"
 ANDROID_API_LEVEL=23
 SSL_SUFFIX=_3

 # ----------------------------------------------------------------------------

 export ANDROID_NDK_ROOT=$ANDROID_NDK
 export PATH="$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin":$PATH

 rm -rf latest
 rm -rf build


function build() {
 rm -rf "latest/$ARCH" && mkdir -p "latest/$ARCH"
 rm -rf build && mkdir -p build && cd build
 ../openssl-openssl-3.1.0/Configure shared android-$ARCH -D__ANDROID_API__=$ANDROID_API_LEVEL
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
 ../openssl-openssl-3.1.0/Configure shared android-$ARCH -D__ANDROID_API__=$ANDROID_API_LEVEL no-asm
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

