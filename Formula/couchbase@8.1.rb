# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "d0a4438ac56d7fdbe245c31f1887d5f621f8fb5c7b62bf65ab8c9c11cddcebdc"
    sha256 arm64_big_sur:  "22801fba4cab99b79b25d9850a9a916f9eccb586559ed6069348b9e0bfee8646"
    sha256 ventura:        "fadb8b11da95343f6aebbaf5a32446460aed06f8652b71fca9e39889386513f3"
    sha256 monterey:       "62740716d71bd74143adf4af4a72d3036000a92fdde18dd6727d08ba76ccb777"
    sha256 big_sur:        "106a2585b1677c3b5dae2d1511ed95bc4c861c5073256dc580f1bfccf7fc922e"
    sha256 x86_64_linux:   "7512569e3335d8860fa7656c67e126239908cd0d06699c606e5036949f76b54e"
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
