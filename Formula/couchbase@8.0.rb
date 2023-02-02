# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_monterey: "8d9f55c1ae7a79cd46a067d076f7216db937945abeed697e1a032e21a5912255"
    sha256 cellar: :any, arm64_big_sur:  "314fc75de2c2e1bf12655ee6670edec3d9d79b36d6d229d35a49caaede8d9b3f"
    sha256 cellar: :any, monterey:       "d602d5484bb57f2a119b7fc8ab2af06cfb404f08e35c6fdcec2fc3ea114738b8"
    sha256 cellar: :any, big_sur:        "98720438c6aeb074a69a084c46bc850b1dd9299ce8bf3df229178da325a88d6c"
    sha256 cellar: :any, catalina:       "6dcd220cb54231bf33b2b25ebdd6abff48bf8a9ebad9d61ffd0ceb89f9f90ca9"
    sha256               x86_64_linux:   "26ca0f8125dc9b8e01d5ac9cb57e0000e33f1933a188de491b66742c3f347262"
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
