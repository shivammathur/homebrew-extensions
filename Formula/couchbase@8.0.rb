# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.0.tgz"
  sha256 "17bffaa656bd51225dc4da2380d5aefbf2de03ea790b5c29841839c1f002b894"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5a0ed5bf8cdd6d016d20c6a8d765c0f2ea986ce783eb7baf37592f60a77c104c"
    sha256 cellar: :any,                 arm64_ventura:  "06a65bf4840833e9a4c7187a0b9ecf27a29a36ede8b2783f55610e55b4ba8f2a"
    sha256 cellar: :any,                 arm64_monterey: "62a9a69fb443b9d19063bd59892857f4377c9d829c39cfcbdd09b7267169fa90"
    sha256 cellar: :any,                 ventura:        "d78205cbc7df14aa5e7b70e421d9b8fe2857bf898491316cb522c73fb0b715ed"
    sha256 cellar: :any,                 monterey:       "738e97b9cab6ae5ac402f60f8f552396c9bd38918a38ee8404d81429bc84b5ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c0386b0d5289c24b6eb64b3a9c15be0b410d8c8dc85efdf38699a854d916be5"
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
