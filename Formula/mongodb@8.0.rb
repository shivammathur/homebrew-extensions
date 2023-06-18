# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "fae0572670d8c5c066c5337efb06ee2dac04c3eeb55068c7dd8e3cd9ec815c30"
    sha256 cellar: :any,                 arm64_big_sur:  "c6e345b4c4ca6d28df5444991e5c71204cce3316cf14eb10554d127e41001a41"
    sha256 cellar: :any,                 ventura:        "d4a33dc565ed183e02aa5adb1c44df10952aa6ff78b31047c0e26080265b35dc"
    sha256 cellar: :any,                 monterey:       "b7973c3e1d4fec66e24b2356805802790c5c6c50982f18752198d6cdeb6e3283"
    sha256 cellar: :any,                 big_sur:        "a38db1d8f436991063f8a9c0dea37097aef8c6d15fff354bf8b43331c8c2cfb1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "addc7aa5cc411e0ce011c334bd46107177ce29159aa11debade740c3fcc2126a"
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
