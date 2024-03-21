# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.0.tgz"
  sha256 "17bffaa656bd51225dc4da2380d5aefbf2de03ea790b5c29841839c1f002b894"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "792bd906e6d3c883e2f74f1b21821fb933fda22877cf46dac73675098bc4194d"
    sha256 arm64_ventura:  "5e03e0b220b19fb0408a08b790f726fadbe62d34a324df369ed393d374bee740"
    sha256 arm64_monterey: "8bc261495dd28c33895388655772eb4539dca349ab7390ad72cfab5c263c52ce"
    sha256 ventura:        "e0f5bc4dce23a84bb3e1bee9908111e086eb875a46bb1c2c46b037d842abd575"
    sha256 monterey:       "271df8db2ca54790fa9e1c7049f3392275fb2aae2b9ed870d2e1d3a802b2b804"
    sha256 x86_64_linux:   "294a029b8bb63858f6ff8e69bf141dac78353223fbee82a3b79fcee7ca7b8a62"
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
