# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.2.tgz"
  sha256 "c5d3109365a47a785ad21713a27cbb3da7205da506bc7bf255ea04fc14d835e2"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0bac8590b96df946cb6f1e29ac14dcbef82d2303add08d272f7feed3f4b4dee0"
    sha256 cellar: :any,                 arm64_big_sur:  "946594a8b7a95de224f6f74d616fc42f134b251a4f01d81bbba903125744c7c9"
    sha256 cellar: :any,                 monterey:       "321b41f202d329c1f9fb7818811dfef01bb4fe4cd1f052d4039d30f4c61027e3"
    sha256 cellar: :any,                 big_sur:        "3e3d84d95f6385533d18fc70f419bc8e52f6ab3be6a412754aca1df08b02fd38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "79eab2a09831c5d05079e0e19e95facb9aca46e7af33cf79f3bfae3ee35f9d57"
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
