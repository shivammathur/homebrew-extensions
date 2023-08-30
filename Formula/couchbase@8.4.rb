# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT84 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "85661d12847ff0b2a6b15bff57e7fdeaf54b1fac1b10f334a5e00696065f3b3f"
    sha256 arm64_big_sur:  "b0d6a7f72ab6ffd427a4ef26bd00e7e146495f25ad338b5a3d40aef807cb4453"
    sha256 ventura:        "1194f2eb616ec67e272b57a9e117adda3695efb55d6ef0420b75abb040e03d19"
    sha256 monterey:       "1826cfe78fb8a2a0c6c96e787f7c7b3a9885a91184bd7eef7a9c28739b6a984b"
    sha256 big_sur:        "056a399dd44aaad29b51a56a978bf50eb5aea1699d5bdc7692afe93873f3bd09"
    sha256 x86_64_linux:   "c6436e588d2b1dfb80a3ec3882db6ed9a91ca683a8a84707d7bd937e6ac6dec2"
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
