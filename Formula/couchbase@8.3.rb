# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "45489d23ec52e66d5aecb12015c56c5998feb16cd86f92fc34dbf02bccfead84"
    sha256 cellar: :any,                 arm64_big_sur:  "9a607f9df61bafdfaddf7c227b01e02d3855eb021a93138eb344b5dd4915e128"
    sha256 cellar: :any,                 monterey:       "4e69455ee385fa1dcac81b483b6f3977deeae71b92b8079d7783383f8bcd67cd"
    sha256 cellar: :any,                 big_sur:        "7debbcff1fe96d138a73bc4e7deb6b4d35a4b39ddb3f99d3f3c6dd0d88b4dfc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb8d2011b3d1ebc597826739b40c5071abb5dd203860861952fa03321ce4f9c7"
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
