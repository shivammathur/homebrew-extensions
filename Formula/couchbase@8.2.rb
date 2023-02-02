# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e8059928bd0970948347b26c2266ce53246212e2e3cad0b2cabac68595a45a9c"
    sha256 cellar: :any,                 arm64_big_sur:  "6e32cde892ac44e7b62ad468c3f81882d1767c728d993333e986e70ab64da44c"
    sha256 cellar: :any,                 monterey:       "f7a7cd6ef86fd61adff4985e28f3b504be3ca4ce4eabc2f577a53aabca3135d6"
    sha256 cellar: :any,                 big_sur:        "065a9327341c2ebd91bfca3ac996b6968777ed1d079faf5ba55f6886734541ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c25fa8c32c2216abf81a31ed9cee6909c75c1b70e421eb3fafa8d44535346ea8"
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
