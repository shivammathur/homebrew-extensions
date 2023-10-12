# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.6.tgz"
  sha256 "43da457eceb494a8fee95cbb7ff9383efe66899f525cf530760507257080597f"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_ventura:  "005db77c99350c6dc68dc77c45c03169d23a685f5a858071de49c892a40ee20f"
    sha256 arm64_monterey: "c00abf2401eddc095fd6bbdf769ae551369bd0e352d1a0ca1245a1327c040ee4"
    sha256 arm64_big_sur:  "3895f5aab2e4a10860df1b01030d9fb4acacf70d87eb9264e0b32e848fb4909a"
    sha256 ventura:        "72d3bf01f308dda1bfbe6a8ed82d69e448df40c82dfee1475c87495d050f6a66"
    sha256 monterey:       "98f33b53467e8334c9dcd03f6a697cfb70f1ebd56d4c58c07059b8050e5d9465"
    sha256 big_sur:        "9ce82ca07ced972d9caab1e648048403a64b0b2b6c477acbadb907bf6e7f0627"
    sha256 x86_64_linux:   "e28f2d5e2fcc01a812c0803a3b81e71c275c4b4f75ca9baa73a64d732dd8000d"
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
    Dir.chdir "couchbase-#{version}"
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
