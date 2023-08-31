# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "80e7d0ec104a72731bf2b02027e1068095b3907613f10c90830c5cd8db0a3b7e"
    sha256 cellar: :any,                 arm64_big_sur:  "f9cffb495b6e4802f120278023e271d0e231a15e5a5227e8aafddb8e7661e9a5"
    sha256 cellar: :any,                 ventura:        "459661672377ad84ea7a637ce6e1aa41a25e383cdc0222c960eb38e9cd7b3c06"
    sha256 cellar: :any,                 monterey:       "89c86f42192bd469d24b1f4872e1cbea8f2d99ac0dcf97900a6b5c2b711a696e"
    sha256 cellar: :any,                 big_sur:        "d4fe004a58b605a6057782de26fa3aa68679f6f6f5e0d865a032b6fe1719042c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39d5d5fa131870f7d6584889d305b7a55eec88d7626a258391965b25d8f6b5c9"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
