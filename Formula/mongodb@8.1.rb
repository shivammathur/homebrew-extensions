# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5330690895e2824ca33ae0424f198fb8b1a56071ff4d145b373161e67c3fe75a"
    sha256 cellar: :any,                 arm64_big_sur:  "092188feea8f11536ffcf832d8dc16bd9a89ecb4df9e726e19dd607a95e54e2d"
    sha256 cellar: :any,                 monterey:       "ea72a4d78aeebbf3ab5a0ea57de4f91f946514ce8c8591d484d449ceb8dcf92c"
    sha256 cellar: :any,                 big_sur:        "e288da7400cc45f7e74b6aa70d88647a5d522f8385451b8452132ac139e2a86b"
    sha256 cellar: :any,                 catalina:       "fba770f3b02a685277855473f1628ce52f3c3305fe5b4a7aafd0cbb3b2f88abe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "941d5480590b72b25ab20ca814d178b54aa0d15d8e7ee2c39a101659525c331b"
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
