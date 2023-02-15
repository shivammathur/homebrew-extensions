# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f235d43deb9f08caa9928f660285c6d53f76819e096ce0e0dc36657bfe5f04ec"
    sha256 cellar: :any,                 arm64_big_sur:  "cefa52ca886144b46de2da02970e676374d4cbfdf6989e7cdb18e96127b27fd9"
    sha256 cellar: :any,                 monterey:       "52f199dcccbfcc111487445b2e0f9bb327dc30cd4af794497347623fe57e658d"
    sha256 cellar: :any,                 big_sur:        "721b20c8442469fa7f72b981138880b7d1962fdf5b29df1590479423a027013e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4399b50d68fac0c96c0f5e1f3e290e7ad88b1f0c56cb400b55d4173e77376e74"
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
