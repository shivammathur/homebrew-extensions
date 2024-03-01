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
    rebuild 2
    sha256 arm64_sonoma:   "69e7416e0f752c42dac6b2b233d081f26cb4acc3917828401254d6bb392b0449"
    sha256 arm64_ventura:  "d10197988c1049bb085a188fe8909b84ddba923f7c442a3a59af904a05e46c8d"
    sha256 arm64_monterey: "d4199f2d991d7c3c6917a6023ad76847dc866c29546a9a57c39fa2e28d2fdb92"
    sha256 ventura:        "2a6d02a153d7c1b45e652d1f507f161dcda3da671487af82b287f9a571655774"
    sha256 monterey:       "44b609b3d3330a6379b9a9afeb2a1d3516f929f5d6852719e7222a9fcc66c14b"
    sha256 x86_64_linux:   "0cebda33f0f886b57a90dfddeb4ad2c36eb5ab6c5a200f8a7a4bdbcf5d1d37f8"
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
