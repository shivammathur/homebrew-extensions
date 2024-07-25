# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.2.tgz"
  sha256 "d93583c9df80b96a53ca02e05aa9b99db7705029333ec7ccf9b65721bb62f100"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "68bc0c5172b1be50eff31403eaaadcfcae443918f2c7039ee61c5d63cbe5d61e"
    sha256 cellar: :any,                 arm64_ventura:  "aae8c6eac1c0d451470da632d4be61ddaea093bcef6eb3737555f09a155700c3"
    sha256 cellar: :any,                 arm64_monterey: "8ec85eab6c5457c706871c5d01e5753a73f8179e40ee512586570a9e5bb1b2fb"
    sha256 cellar: :any,                 ventura:        "1c6bddbd0e1be308b60fd5b9af8bb9ce1e85bb39b2d6405cecbcfac34f14e346"
    sha256 cellar: :any,                 monterey:       "376b155182a6015c738d9443971088f10004ed9487f503fb8d22d8f60796ed14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efcb6b35c58d19f5b1e8698b98ebe10327d1c8847f299f9acf2ef87f1454ab9c"
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
