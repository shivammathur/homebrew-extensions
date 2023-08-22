# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Couchbase Extension
class CouchbaseAT83 < AbstractPhpExtension
  init
  desc "Couchbase PHP extension"
  homepage "https://github.com/couchbase/couchbase-php-client"
  url "https://pecl.php.net/get/couchbase-4.1.5.tgz"
  sha256 "e1335d70e10687e969ec73b546995d1fe8937ebe511d97c71bbaf2d66056d9f5"
  head "https://github.com/couchbase/couchbase-php-client.git", branch: "main"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "19df371531ae752584eeb6bfd5b97670ab004ff037ab8aec67bc8937aae6139b"
    sha256 arm64_big_sur:  "cc45aa46c83b6d97ff9276da0163f68e22915cac2473fc32747e49986366650c"
    sha256 ventura:        "643d9a8324f9c7f95dfb343d67878dd7aef3eb8e4ddefd03695a60dc1696ea1a"
    sha256 monterey:       "0f9b80815998816a5e89dd97acffcabbcb858d665738258e33bba1b058986642"
    sha256 big_sur:        "5f7b26cd3ff108bd019b33a2d80faf0a384c1c34fbb681676618e9196110812c"
    sha256 x86_64_linux:   "f32e9422020283f197baff12ff83f899dd849389cc895160611188cde69d6127"
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
    inreplace "src/wrapper/common.hxx", "zend_bool", "bool"
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
