# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "453bfd2ec7377de9cd1eb2dd22e819b01417c3807917749030c20edea5bc532c"
    sha256 cellar: :any,                 big_sur:       "161abb34794c0d57c8a18e5e7856f485fa1d5c63e17de3c6795c55e32a93c3b7"
    sha256 cellar: :any,                 catalina:      "d142620a2b0690c463a14d9e711813aa7d41f178540c0317d490e614feff4f6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac1b41d207d082daef25e464543346afd3a5debc7fceb6d099fc24b6f5098701"
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
