# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "4555f23b3cef5ba6097c6e056b7622fae15ad58131ec04eef306ac9f99aca5f9"
    sha256                               arm64_big_sur:  "bd54e8118607cbaa7f4811445b228bc20261a7d348825a71f5dd714b199ef1e7"
    sha256                               monterey:       "070babc86e70b9dd9bf151a81d82b6797a41aa26823ebbdb0a3a494d2347e41a"
    sha256                               big_sur:        "604ea416524f90efb33a18ca7be2e9730eecab0ea9387b705a566742dccf6eaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "875af69950ec9074b51ecbb9fcd0ed0d5b7f709616a0b23ed9e124843da75373"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"
  depends_on "zlib"

  on_linux do
    depends_on "gcc" # C++17
  end

  fails_with gcc: "7"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "#{Formula["openssl@1.1"]}.opt_prefix"
    Dir.chdir "couchbase-#{version}"
    inreplace "src/wrapper/common.hxx", "zend_bool", "bool"
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
