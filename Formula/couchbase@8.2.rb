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
    sha256 arm64_monterey: "90f894d9b7f2749994445add2688b15c461e2210e2247f8e29b37dbeefd836fd"
    sha256 arm64_big_sur:  "c9ac7eec2d6007f3f425192fe38dcab9d985f26b1f08ce26241f7627303e98b8"
    sha256 ventura:        "c7922501bd02ca833b398c4de0c6c465133522100235935c34c873f508f426cb"
    sha256 monterey:       "876f5949615e4da458b08090a49ee518a1455e363adf75cef0d17f402bbb0230"
    sha256 big_sur:        "5925968977eb2d1277c145142b3d33bfc5885cb637a03962f746bc0f01b29ed6"
    sha256 x86_64_linux:   "32e0fbb7ce8ccb0677657b80d1c65c55971d78cd0a33c875c920e8318cef0405"
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
