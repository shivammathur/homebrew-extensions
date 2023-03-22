# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7245ae814fc3a6d9ce9c30b2c465ba99745910b716be904c0bb0121a0daca73e"
    sha256 cellar: :any,                 arm64_big_sur:  "49c7a683f5dde0a77d84610070a02af3ac0af42877c49379832d90772b20b07a"
    sha256 cellar: :any,                 monterey:       "8a65b4b94e1030b3a52263c759518bfe108b5a13702055727381bc47e79e7779"
    sha256 cellar: :any,                 big_sur:        "3ce0a8d4b397492915c51bee73739156644cc55b173c125dbcdfea2b1ada91c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf5c3c3d94ad1bf83a8eb41d46ab96481b64fc72a465a8bdc2151261a97cbef4"
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
