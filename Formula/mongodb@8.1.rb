# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b65d3ef19a033a36157f58a837cedded1e935c93414e678c102fa2acae6518be"
    sha256 cellar: :any,                 arm64_big_sur:  "621623f522f2258405f017b41d5f69e1fae9bfa20fec136e365dde754cbde5a8"
    sha256 cellar: :any,                 ventura:        "ba13804f2ae97679aa2dc74ad24deb73ebe4cd6de14a6a678438d48b09c50433"
    sha256 cellar: :any,                 monterey:       "2e180eb7fd92df57e72384d00de6277df54c0049570965cfed5ccbb8289496f0"
    sha256 cellar: :any,                 big_sur:        "6258c2237a0af212ef1f4cbaf9168b01146132f476f23648a541cc86b1bbdb20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d737326209092c0d93c2f4073ed077d63c07316364c9957ff5d908469b034768"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
