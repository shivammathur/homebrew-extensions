# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "f8fe89ea5642664b5df79eda4a619e81398119b21c615c019138013d0216ca1f"
    sha256 arm64_big_sur:  "4f5b5c56c01f2e6ef098c13f586f18426c6e1cd3bafc83ef8cce9ed86e44e9fd"
    sha256 ventura:        "5370e6e14961a544162bd7a092fd05a3e06997330448f1701d85264100fbd1b5"
    sha256 monterey:       "6af6b3c2c53a155d14d174aacbdcec4ec485a3153092cd3de6a839dedf3a7bfb"
    sha256 big_sur:        "9ac7941374eb8e1a81e3f5c2067285dc6453931c65098e9e1375e57fc8df719f"
    sha256 x86_64_linux:   "89d151731f1efdf1720d9659097fab3db55a62e5357584272e4c40fda4f3ecf0"
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
