# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f8ea601803669b717f3c85c15c69035040e23e028fae0fe582d481e7112fc975"
    sha256 cellar: :any,                 arm64_big_sur:  "4226815941c6e11be8af192b7e5f79f390e6740f3cf69eea6de2286f5c957676"
    sha256 cellar: :any,                 monterey:       "5509f3bdb218bcf7ac3fc81c533f4f13d2e2dd15a1729f428422d5257b0c6e60"
    sha256 cellar: :any,                 big_sur:        "d25d0b90c61b02d33f3cea67be3638450d1cdf21472534028ca735f5408a16eb"
    sha256 cellar: :any,                 catalina:       "75d639a0bb695b3043d81a7056cf10f6e1da89a85abd029a7cc09df8e3e3e4a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66ae5e5664c969ac7bb236b7907b2aa582ef046008b4effa2c9cb8bad4b89bcc"
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
