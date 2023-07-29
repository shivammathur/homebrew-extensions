# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT82 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.4.tgz"
  sha256 "80ba7dbabb7f7a275907507186ecb27b559e64082a22ba1ad39cdd129d383ce5"
  revision 1
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_monterey: "da14bcd05eeaeeb13cd991b422a84802f35a5f3f766ec14e5fc65a578f80da4f"
    sha256                               arm64_big_sur:  "6397193e15185742e4ac8f74c296d594f305fe3779185702d0eda05e5ad099df"
    sha256                               ventura:        "a10f09a44e6e454256d4699d87f7ad6c73cefe85fc54efac3e56ff0c1985de04"
    sha256                               monterey:       "82d8ed53ddf61237845b24ba4ccfbac492f22d257968ce6f1f5f53b0c18cabd0"
    sha256                               big_sur:        "d02b2ae41341779353c0a97fdcde803da95f36cd5d5b13f9343794cc0d01171a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26db5910db3b6717609c8c9535431a1b3b2616e431d6bb4a60f8cf07ce91cb83"
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
