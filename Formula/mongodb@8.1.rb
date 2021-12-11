# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "03cd9e0c03c6be210cb8866f25d271493ea39adf5a26834972f88c1aece9f711"
    sha256 cellar: :any,                 big_sur:       "d8f52edd9c92becd14391840f0b4d916f943d366520ed435ab26dc618a4e00a2"
    sha256 cellar: :any,                 catalina:      "629dd7b00e6677917f12125fae5173afc81647a7431bc86a41db2430753826e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a87fbc3725bf8b27585234a31c37f3f11e654d03ee458db1b4c9bf7ae69b088"
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
