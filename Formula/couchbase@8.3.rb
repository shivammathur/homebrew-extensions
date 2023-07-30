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
    sha256 arm64_monterey: "5c2b4c63091824a3422bb19bb2903f3b332b984c715e8a612d9de215df666b34"
    sha256 arm64_big_sur:  "06865af9ff8257cdbdcd68a99507dc4e6d153a4b7c559d13fb85a071dd8faf5a"
    sha256 ventura:        "71893b2ff93ab8db1202aad02414cd8fd022fa2ed8216c1b82759d37a71708a9"
    sha256 monterey:       "5eb09609793a1a340c5f2b194486ca0aa3bdd5d68f073b7e9d6fa83f637b755c"
    sha256 big_sur:        "dd9e8cc2c241f7cdfbba6ef86f076500693a74a5cb6c04bdebc08cb485dc22c9"
    sha256 x86_64_linux:   "16961c128677a19b6bf504f7e5b381ff3e42cc07966987fe5c52d98a312b2019"
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
