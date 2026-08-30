#!/usr/bin/env bash
# Build a fully static curl with ECH and other experimental features enabled.
# Runs on macOS and Linux (x64/arm64); used locally and by .github/workflows/build-curl.yml.
#
# Inputs (env): CURL_VERSION, OPENSSL_VERSION, NGHTTP2_VERSION, NGTCP2_VERSION,
#               NGHTTP3_VERSION, BROTLI_VERSION, ZSTD_VERSION, ECH_SEQ, WORK
# Output: $WORK/curl-${CURL_VERSION}-ech.${ECH_SEQ}-${os}-${arch}.tar.gz
set -euo pipefail

CURL_VERSION="${CURL_VERSION:-8.21.0}"
OPENSSL_VERSION="${OPENSSL_VERSION:-4.0.2}"
NGHTTP2_VERSION="${NGHTTP2_VERSION:-1.70.0}"
NGTCP2_VERSION="${NGTCP2_VERSION:-1.25.0}"
NGHTTP3_VERSION="${NGHTTP3_VERSION:-1.18.0}"
BROTLI_VERSION="${BROTLI_VERSION:-1.2.0}"
ZSTD_VERSION="${ZSTD_VERSION:-1.5.7}"
ECH_SEQ="${ECH_SEQ:-1}"

WORK="${WORK:-$PWD/.curl-build}"
SRC="$WORK/src"
PREFIX="$WORK/prefix"
PAYLOAD="$WORK/payload"
mkdir -p "$SRC" "$PREFIX" "$PAYLOAD"

case "$(uname -s)-$(uname -m)" in
  Darwin-arm64)  os=darwin; arch=arm64;  JOBS=$(sysctl -n hw.ncpu) ;;
  Darwin-x86_64) os=darwin; arch=x64;    JOBS=$(sysctl -n hw.ncpu) ;;
  Linux-aarch64) os=linux;  arch=arm64;  JOBS=$(nproc) ;;
  Linux-x86_64)  os=linux;  arch=x64;    JOBS=$(nproc) ;;
  *) echo "unsupported platform: $(uname -s)-$(uname -m)" >&2; exit 1 ;;
esac

case "$os" in
  darwin) CA_BUNDLE=/etc/ssl/cert.pem ;;
  linux)  CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt ;;
esac

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export CPPFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

fetch() { # fetch <filename> <url>
  local file="$SRC/$1" url="$2"
  if [ ! -f "$file" ]; then
    echo "== downloading $1"
    curl -fL --retry 3 -o "$file" "$url"
  fi
}

extract() { # extract <tarball> [strip-level]
  local tarball="$1" strip="${2:-1}" dir
  dir="$WORK/$(basename "$tarball" | sed -E 's/\.(tar\.(gz|xz|bz2)|tgz|zip)$//')"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    tar -xf "$tarball" -C "$dir" --strip-components="$strip"
  fi
  echo "$dir"
}

echo "== versions: curl=$CURL_VERSION openssl=$OPENSSL_VERSION nghttp2=$NGHTTP2_VERSION ngtcp2=$NGTCP2_VERSION nghttp3=$NGHTTP3_VERSION brotli=$BROTLI_VERSION zstd=$ZSTD_VERSION"

# GitHub x64 runners ship Homebrew openssl@3 whose 3.x headers (no ECH API) sit
# in /usr/local/include and can shadow our 4.0.2 build. CI-only: never touch the
# local machine's brew packages.
if [ "${GITHUB_ACTIONS:-}" = true ] && [ "$(uname -s)" = Darwin ] && command -v brew >/dev/null; then
  brew uninstall --ignore-dependencies openssl@3 openssl@1.1 >/dev/null 2>&1 || true
  if [ -e /usr/local/include/openssl ] || [ -e /opt/homebrew/include/openssl ]; then
    echo "ERROR: Homebrew openssl headers still present" >&2
    exit 1
  fi
fi

# --- fetch sources -----------------------------------------------------------
fetch "curl-$CURL_VERSION.tar.xz" \
  "https://github.com/curl/curl/releases/download/curl-${CURL_VERSION//./_}/curl-$CURL_VERSION.tar.xz"
fetch "openssl-$OPENSSL_VERSION.tar.gz" \
  "https://github.com/openssl/openssl/releases/download/openssl-$OPENSSL_VERSION/openssl-$OPENSSL_VERSION.tar.gz"
fetch "nghttp2-$NGHTTP2_VERSION.tar.xz" \
  "https://github.com/nghttp2/nghttp2/releases/download/v$NGHTTP2_VERSION/nghttp2-$NGHTTP2_VERSION.tar.xz"
fetch "ngtcp2-$NGTCP2_VERSION.tar.xz" \
  "https://github.com/ngtcp2/ngtcp2/releases/download/v$NGTCP2_VERSION/ngtcp2-$NGTCP2_VERSION.tar.xz"
fetch "nghttp3-$NGHTTP3_VERSION.tar.xz" \
  "https://github.com/ngtcp2/nghttp3/releases/download/v$NGHTTP3_VERSION/nghttp3-$NGHTTP3_VERSION.tar.xz"
fetch "brotli-$BROTLI_VERSION.tar.gz" \
  "https://github.com/google/brotli/archive/refs/tags/v$BROTLI_VERSION.tar.gz"
fetch "zstd-$ZSTD_VERSION.tar.gz" \
  "https://github.com/facebook/zstd/releases/download/v$ZSTD_VERSION/zstd-$ZSTD_VERSION.tar.gz"

# --- OpenSSL (static; ECH + QUIC are in 4.0.x mainline) ----------------------
openssl_dir=$(extract "$SRC/openssl-$OPENSSL_VERSION.tar.gz")
if [ ! -f "$PREFIX/lib/libcrypto.a" ]; then
  echo "== building openssl $OPENSSL_VERSION"
  (cd "$openssl_dir" \
    && ./Configure no-shared no-tests --prefix="$PREFIX" --openssldir="$PREFIX/ssl" \
    && make -j"$JOBS" \
    && make install_sw)
fi

# --- nghttp3 ----------------------------------------------------------------
nghttp3_dir=$(extract "$SRC/nghttp3-$NGHTTP3_VERSION.tar.xz")
if [ ! -f "$PREFIX/lib/libnghttp3.a" ]; then
  echo "== building nghttp3 $NGHTTP3_VERSION"
  (cd "$nghttp3_dir" \
    && ./configure --prefix="$PREFIX" --enable-lib-only --disable-shared \
    && make -j"$JOBS" \
    && make install)
fi

# --- ngtcp2 (needs OpenSSL with QUIC API) ------------------------------------
ngtcp2_dir=$(extract "$SRC/ngtcp2-$NGTCP2_VERSION.tar.xz")
if [ ! -f "$PREFIX/lib/libngtcp2.a" ]; then
  echo "== building ngtcp2 $NGTCP2_VERSION"
  (cd "$ngtcp2_dir" \
    && ./configure --prefix="$PREFIX" --enable-lib-only --disable-shared \
    && make -j"$JOBS" \
    && make install)
fi

# --- nghttp2 ----------------------------------------------------------------
nghttp2_dir=$(extract "$SRC/nghttp2-$NGHTTP2_VERSION.tar.xz")
if [ ! -f "$PREFIX/lib/libnghttp2.a" ]; then
  echo "== building nghttp2 $NGHTTP2_VERSION"
  (cd "$nghttp2_dir" \
    && ./configure --prefix="$PREFIX" --enable-lib-only --disable-shared \
    && make -j"$JOBS" \
    && make install)
fi

# --- brotli -----------------------------------------------------------------
brotli_dir=$(extract "$SRC/brotli-$BROTLI_VERSION.tar.gz")
if [ ! -f "$PREFIX/lib/libbrotlidec.a" ]; then
  echo "== building brotli $BROTLI_VERSION"
  cmake -S "$brotli_dir" -B "$brotli_dir/build" \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_BUILD_TYPE=Release
  cmake --build "$brotli_dir/build" --parallel "$JOBS"
  cmake --install "$brotli_dir/build"
fi

# --- zstd -------------------------------------------------------------------
zstd_dir=$(extract "$SRC/zstd-$ZSTD_VERSION.tar.gz")
if [ ! -f "$PREFIX/lib/libzstd.a" ]; then
  echo "== building zstd $ZSTD_VERSION"
  cmake -S "$zstd_dir/build/cmake" -B "$zstd_dir/build/cmake-out" \
    -DBUILD_SHARED_LIBS=OFF \
    -DZSTD_BUILD_SHARED=OFF \
    -DZSTD_BUILD_PROGRAMS=OFF \
    -DZSTD_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_BUILD_TYPE=Release
  cmake --build "$zstd_dir/build/cmake-out" --parallel "$JOBS"
  cmake --install "$zstd_dir/build/cmake-out"
fi

# --- curl -------------------------------------------------------------------
# macOS ld searches dylibs before static libs across all -L paths; a stray
# shared lib here would silently win over our .a and break the static build.
ls "$PREFIX"/lib/*.dylib "$PREFIX"/lib/*.so 2>/dev/null \
  && { echo "ERROR: shared libs found in $PREFIX/lib" >&2; exit 1; } || true

# The 4.0.2 headers must expose the ECH API end to end; a missing piece here
# means a foreign openssl header set is shadowing ours.
grep -q "OSSL_ECHSTORE" "$PREFIX/include/openssl/types.h" \
  || { echo "ERROR: $PREFIX/include/openssl/types.h lacks ECH typedef" >&2; exit 1; }
grep -q "define SSL_OP_ECH_GREASE" "$PREFIX/include/openssl/ssl.h" \
  || { echo "ERROR: $PREFIX/include/openssl/ssl.h lacks ECH options" >&2; exit 1; }
grep -q "OSSL_ECHSTORE_new" "$PREFIX/include/openssl/ech.h" \
  || { echo "ERROR: $PREFIX/include/openssl/ech.h incomplete" >&2; exit 1; }

curl_dir=$(extract "$SRC/curl-$CURL_VERSION.tar.xz")
echo "== building curl $CURL_VERSION"
if ! (cd "$curl_dir" \
  && ./configure --prefix="$PAYLOAD" \
    --with-openssl="$PREFIX" \
    --enable-ech \
    --enable-httpsrr \
    --with-nghttp2="$PREFIX" \
    --with-ngtcp2="$PREFIX" \
    --with-nghttp3="$PREFIX" \
    --with-brotli="$PREFIX" \
    --with-zstd="$PREFIX" \
    --with-zlib \
    --with-ca-bundle="$CA_BUNDLE" \
    --without-libpsl \
    --without-libidn2 \
    --without-libssh2 \
    --disable-ldap --disable-ldaps \
    --disable-shared --enable-static \
    LDFLAGS="$LDFLAGS -Wl,-search_paths_first" \
  && make -j"$JOBS" \
  && make install); then
  echo "== diagnostics: curl lib CPPFLAGS" >&2
  grep -E "^CPPFLAGS" "$curl_dir/lib/Makefile" 2>/dev/null | head -3 >&2
  echo "== diagnostics: config.log ECH probe" >&2
  grep -B2 -A10 "set1_ech_config_list" "$curl_dir/config.log" 2>/dev/null | tail -30 >&2
  exit 1
fi

# --- sanity checks ----------------------------------------------------------
CURL_BIN="$PAYLOAD/bin/curl"
"$CURL_BIN" --version
"$CURL_BIN" --help all | grep -- '--ech' >/dev/null \
  || { echo "ERROR: --ech not available, ECH support missing" >&2; exit 1; }
"$CURL_BIN" --version | grep HTTP3 >/dev/null \
  || { echo "ERROR: HTTP3 missing" >&2; exit 1; }
if [ "$os" = darwin ]; then
  otool -L "$CURL_BIN" | sed -n '1,20p'
  ! otool -L "$CURL_BIN" | grep -qE 'libssl|libcrypto|libnghttp|libbrotli|libzstd|/opt/homebrew|/usr/local' \
    || { echo "ERROR: binary links to non-system dylibs" >&2; exit 1; }
fi

# --- package ----------------------------------------------------------------
tarball="$WORK/curl-$CURL_VERSION-ech.$ECH_SEQ-$os-$arch.tar.gz"
tar -czf "$tarball" -C "$PAYLOAD" bin share
echo "== built $tarball"
shasum -a 256 "$tarball"
