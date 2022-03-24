# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.13.0.tgz"
  sha256 "22865b61d264c90c9eaa85d94f2f5f57e564140cad87c8c2601fa33f80efe0bb"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "299c4c9a1bd0f589a228033a523eae3b1f57ac979d342ff990db3abde88fc43b"
    sha256 cellar: :any,                 big_sur:       "919e823ac3f7fcb118e2516e2d38bc6957186112c5f9f2c8e70002ee946766d3"
    sha256 cellar: :any,                 catalina:      "734a13a4d2b79c4e95b01bd99d4dd696673de0b4f0f9514bcfe4e40cf0de3a09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53a990d39996dc09ad6e2287bd7b882a70ca9fa6d836bd2158d7046ce253807f"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
