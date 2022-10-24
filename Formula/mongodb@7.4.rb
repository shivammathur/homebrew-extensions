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
    sha256 cellar: :any,                 arm64_monterey: "5467571179428c0ecde29ae2c5c51758b160a6cac928d2aef60cb2701360c139"
    sha256 cellar: :any,                 arm64_big_sur:  "c4d6c00c87c822966effb20ea9b2f3def8884e8087023b080717801c24502b18"
    sha256 cellar: :any,                 monterey:       "ff8599b59b529ef3932f8540613b191fa07c45774ef57de8bfdcca3326ed1db5"
    sha256 cellar: :any,                 big_sur:        "2c5edfac45637f6397f615e8408b4f7a948286514eea27e9fa2c9ec7c351ed97"
    sha256 cellar: :any,                 catalina:       "25c84e605647e6f8c81349ecdf756a769f04b13424920becba590c591bb123f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "558277c7a75d4ce33876cac25f3355fa13f171d77d1195f111c8470f4d77f702"
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
