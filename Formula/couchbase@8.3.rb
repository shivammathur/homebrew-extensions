# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.0.tgz"
  sha256 "17bffaa656bd51225dc4da2380d5aefbf2de03ea790b5c29841839c1f002b894"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "9e46a86239ab972b3d404f028cdf4c259e950b6a20fda6c18f2784b813d81c48"
    sha256 arm64_ventura:  "dbcbfc886d77dc2037d43704cfdade24355cd0577d9d7b199847cad0253e95e2"
    sha256 arm64_monterey: "922da13eb848507d368234011768419c302af695b0cfa2750aa9b923346f7090"
    sha256 ventura:        "feed69c887805bfce0d2e56bd23b0a4726e6d0dbf4f75f5d2a3d8e98b0f29c94"
    sha256 monterey:       "5dc06ce2468f6f4835b7eeb449698b4326e476d76bcfe3106e8bc524fae3831f"
    sha256 x86_64_linux:   "9c2e2d5ca00ebe9aab063b8d0af194f9875584330c2bfff01ab1df363fc9e9b8"
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
