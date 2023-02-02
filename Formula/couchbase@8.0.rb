# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT80 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.0.tgz"
  sha256 "3f027727615848da928df347bf1cbe7a867f8a362b56eefe8b2457795f8b4492"
  head "https://github.com/couchbase/couchbase-php-client.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c4d64e4bdebe8cb21f3d8c50c5d77ca93c1b9d6081e6fa1945d8660804f17f28"
    sha256 cellar: :any,                 arm64_big_sur:  "4f1c788ffff538c76a6b07dc92d5a370d52f07649cb1b6fcff35c7b84cea91d3"
    sha256 cellar: :any,                 monterey:       "1239ecb53b5c424e198b7546911c2585bd4ed03d8dd61db3a2d207a3be7b8d39"
    sha256 cellar: :any,                 big_sur:        "a1e3fb6d8fa9b56342e6235689d89ddf38f38c759adde104950a4717f8601efe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48ddade40b66b16d1658f12a2e022850446aaaf1833c51f26a2439568c92c637"
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
