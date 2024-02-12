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
    rebuild 1
    sha256 arm64_sonoma:   "f60d6b7e8b62b1a55f64644cfa1e5bc7b5f9beecde7d52ef9655cc4f087cec3d"
    sha256 arm64_ventura:  "a520ba100bba2859d1413281e21d6d7cc43bfbad30e3dcd5d1ae4fb2917b526e"
    sha256 arm64_monterey: "a044c3ffa35de6d5434a53867649e17d68e30b405652b1c7bbba9d4f1b4afadc"
    sha256 ventura:        "3f33a5c796a4adfedcf815c288b5c48cc4d811c21ab57223464bbcb38b4bbcfc"
    sha256 monterey:       "8acfc5ff3aced38c7c9d11f31d3a0fc9e5540197567c85ed9613851a3c99e159"
    sha256 x86_64_linux:   "73586acf9ac60474a2b31af5fdab0748e6ab96263b550beb6c3f935232054425"
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
