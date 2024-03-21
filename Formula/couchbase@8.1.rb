# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.0.tgz"
  sha256 "17bffaa656bd51225dc4da2380d5aefbf2de03ea790b5c29841839c1f002b894"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "1fba42d39b2f7c5a3cb12e524985bcf85edcd4c207dc7934aef2c4e0c734a4ae"
    sha256 arm64_ventura:  "2e8a5ed60efa5bf87d01d4cc50548dff7d4b10513094ab23988ccf2e8a254e69"
    sha256 arm64_monterey: "1cb7705b6244a3eb2fc683512e3c756673781df025013ca2502e54e866935d9d"
    sha256 ventura:        "5dca3a57b418b473f8ff761047e76e8bbb7cc7a0e88be767992571feab037244"
    sha256 monterey:       "e4ce7322f004201ec0a9c6e1cd04799a82d5f3e1efa29b5f55acdd6cf4c01563"
    sha256 x86_64_linux:   "36faad41630375aa9788a03ffb278bc0b29d5ac2328d98b15c3c565b2262b4a6"
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
