# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.0.0.tgz"
  sha256 "caa67e972a8e0f50b920088434eea14671902f253fb5bfb854b7e8d3898bcd26"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "21ebcd05b5600bcb3caa5e2456ac98a3f43be3ebbdacf2ad8c3233ff6d18486c"
    sha256 cellar: :any,                 arm64_big_sur:  "395612db80ae7201f20d906b2eec96294e113c34843375444c39dce2003a5713"
    sha256 cellar: :any,                 monterey:       "ce1887cfc18a10359f5f1531b28fd92317158de91cefcf56a929721aec03b943"
    sha256 cellar: :any,                 big_sur:        "9ad3eaf3cfcf217b74f3c0d9ccf668b2475231932fa24d53bfef00c49a19af74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0a163c29b925be520d81f2610ce5f71bf3f31d5739c7cc0363a91bf795c357e1"
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
