# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c7dd315868773563998ac19287fd8ee9d14483f0126e9040cf60591272cee609"
    sha256 cellar: :any,                 arm64_big_sur:  "0666dca5f8d83b8c04a817bfae09a320b57703cb69caef94d226974f8f88d0c6"
    sha256 cellar: :any,                 monterey:       "2c243b4483713cedddb8ebf463cac5c5a7b74bbe07a9973d46a72ece3f602774"
    sha256 cellar: :any,                 big_sur:        "3f2eeb9269336f87ddb7cd1114434f2df82d45c24618d4ca74d47bbe98602ac9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d762418baecb3f4c2e1adce4646c9baaa997d15e92e06d7535f5cbe3edfd11d"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
