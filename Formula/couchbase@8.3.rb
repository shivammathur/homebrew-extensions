# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "9d27163ca609d553fe148d1e33b74278961cab1e34d10ac6bc5f655dc07936f1"
    sha256 arm64_big_sur:  "4ef851af83d828af98bbb4c194a1bcdd18ba8074853938be43bfc2d6618b8f49"
    sha256 ventura:        "b7124456059599495048af0cf9add5fcd5fe1abefb2b43b1c35298651122564f"
    sha256 monterey:       "a1aa9ec3bb54fc39df117193b46a09b8ecac3e2f00cce565fe7b96a600628493"
    sha256 big_sur:        "f911336eeb5e8a3a750f97cac89e3864ffd68fa488ad3b14b7737d91babe3a2b"
    sha256 x86_64_linux:   "936047d7f3feec4f04da60bcb1fcd1ac3cd7bf0a4bb945786fc5c015c42a46b5"
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
