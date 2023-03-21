
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set (SSL_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/no-asm)
else()
    set (SSL_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR})
endif()


if (CMAKE_ANDROID_ARCH_ABI STREQUAL "armeabi-v7a")
    set(ANDROID_EXTRA_LIBS
        ${SSL_ROOT_PATH}/arm/libcrypto_3.so
        ${SSL_ROOT_PATH}/arm/libssl_3.so
    CACHE INTERNAL "")
endif()
if (CMAKE_ANDROID_ARCH_ABI STREQUAL "arm64-v8a")
    set(ANDROID_EXTRA_LIBS
        ${SSL_ROOT_PATH}/arm64/libcrypto_3.so
        ${SSL_ROOT_PATH}/arm64/libssl_3.so
    CACHE INTERNAL "")
endif()
if (CMAKE_ANDROID_ARCH_ABI STREQUAL "x86")
    set(ANDROID_EXTRA_LIBS
        ${SSL_ROOT_PATH}/x86/libcrypto_3.so
        ${SSL_ROOT_PATH}/x86/libssl_3.so
    CACHE INTERNAL "")
endif()
if (CMAKE_ANDROID_ARCH_ABI STREQUAL "x86_64")
    set(ANDROID_EXTRA_LIBS
        ${SSL_ROOT_PATH}/x86_64/libcrypto_3.so
        ${SSL_ROOT_PATH}/x86_64/libssl_3.so
    CACHE INTERNAL "")
endif()
