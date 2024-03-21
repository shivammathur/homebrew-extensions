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
    sha256 arm64_sonoma:   "1806856206cb35c80cecfd6ce4cd19e13b0f8c248c3e1c5980eff4dfd58a03eb"
    sha256 arm64_ventura:  "a83bc65b252126135c09fe8d36d03c8c01be0296c627e50d03a92b89af2a66b2"
    sha256 arm64_monterey: "b175b5fc129d2e94ba85a2d61df4be87adf2bcf23b0db641fe012d3473ff955a"
    sha256 ventura:        "d35b19c9dde5cd9f42dae0e4eff5c8451faa854debc7b4ec45d720ff08abea7b"
    sha256 monterey:       "5624a152014463fed8945e46ef3beb18213aa04e9fc2d25cb9f6bd0e64a61033"
    sha256 x86_64_linux:   "d84fc567113ce520c541d64ffc6d453c4be5eeb7f63cf5a062b3c60c5ac21091"
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
