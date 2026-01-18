GCC_VER = 14.2.0
BINUTILS_VER = 2.44

GCC_CONFIG += --enable-default-pie --enable-build-warnings=,-Wno-format-nonliteral,-Wno-format-security

COMMON_CONFIG += --disable-nls
GCC_CONFIG += --disable-libquadmath --disable-decimal-float
GCC_CONFIG += --disable-libitm --disable-fixed-point

# Use system zlib to avoid build failures on macOS 15+
# https://sourceware.org/bugzilla/show_bug.cgi?id=32935
BINUTILS_CONFIG += --with-system-zlib
GCC_CONFIG += --with-system-zlib
