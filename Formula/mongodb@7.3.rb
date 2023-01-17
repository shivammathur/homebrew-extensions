# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/mongodb@7.3-1.15.0"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "00fbff2584e3d28c4aa8092d19a8b49087a99a94b190bcce793b80502b99313c"
    sha256 cellar: :any,                 arm64_big_sur:  "2458b6563020c9184039a58164ab34b801603e3840b18b6778c9c897980f54e4"
    sha256 cellar: :any,                 monterey:       "d5d6453c04a67c7dbf9269093fd046fb64029b511fbb47730a98927b216a48bc"
    sha256 cellar: :any,                 big_sur:        "15b73a6957eec377d3c5d1baf326bd14ede29d06393a7290b273c4c8c57a9cf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d920ee593c4420b59efd062e63b7a4b4d6b384fb0b6d215713541a74f97f1d2a"
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
