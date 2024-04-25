# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT81 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.2.1.tgz"
  sha256 "89c3a72ceb4afb1399fc5320129a491fad5dc58b4a482fcfb526e6267e729f88"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "85e36bd6d2bb78ce9ecc079f779126b6acdcfe360e5700922ab023e7a81046f2"
    sha256 cellar: :any,                 arm64_ventura:  "2f612e1e037808d7d21d36de84c4e51f796890570b4440208b62dd9b166d5a72"
    sha256 cellar: :any,                 arm64_monterey: "9004b412ce588c24a69b09d0d97763bfd14fd204f4d03f194284827686dde66f"
    sha256 cellar: :any,                 ventura:        "3751ff03c527e552086a77c78a5a1ed2281ad503ac494e662f200fdca1ef69bc"
    sha256 cellar: :any,                 monterey:       "6997fa81fbc81ccebd02e3240076e7f051c04a0d86889afcb3ef8a1e025e1487"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fb05516d33aa9ee4b20ef08f95291d994c0e74edc8663a9539adcbf2dca38f1"
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
