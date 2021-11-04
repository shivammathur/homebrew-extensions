# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "b940efbacd3a1ba58563480943f298f532e6a6b97219e7b724d01b15dbc5a4c1"
    sha256                               big_sur:       "e58d18b2809069379b91eef4c0f23f26e19598e2c3f1d198b2ffee05a372e04f"
    sha256                               catalina:      "b1639d9f09abe785e0bf39e75efe5f93c07a51d67ae6b2dd14d80227e940cf64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8772ebefdfc60012373a368945406381420f348ebc6273d1642ae58341198af4"
  end

  depends_on "icu4c"
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
