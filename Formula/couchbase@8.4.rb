# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://github.com/couchbase/couchbase-php-client.git",
      branch:   "main",
      revision: "1494ce9e90841ca614b2d70e9acc1bd2cc388f89"
  version "4.1.6"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "d42cadcccca10de6cb419d9a0a64fab526241a2a66e185c9ceca8b4bea28cce8"
    sha256 arm64_ventura:  "d5c36aa1f3d13a82f0f302a511ac2afb5aff878471a863c34b8c3a890be43865"
    sha256 arm64_monterey: "61e38fbd15ff2729596037272247ffe394a7dab72a32fa282b32642f4e9c6ad9"
    sha256 ventura:        "448650790836565299103ad1e603cb5806e54298d1cb35b7c2f879521f95952e"
    sha256 monterey:       "9816a13086e8d00cc606311d22804222f6201d8d94ed2b4a5cf30c10723d183c"
    sha256 x86_64_linux:   "f3d75ef6c912110818d7c1e630ce2fec85a5e15a4a2973ad8c0c8db080b2fe2f"
  end

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@3"]}.opt_prefix"
    ENV["CURL_SSL_BACKEND"] = "SecureTransport"
    safe_phpize
    inreplace "configure",
      "EXTENSION_DIR=`$PHP_CONFIG --extension-dir 2>/dev/null`",
      "EXTENSION_DIR=#{prefix}"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-couchbase"
    system "make"
    system "make", "phpincludedir=#{include}/php", "install"
    write_config_file
  end
end
