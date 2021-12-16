# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5f05fece285bc28263e0100aa534f4db2d93ec5bbc1ba5337cbaefd92155d966"
    sha256 cellar: :any,                 big_sur:       "a55f618fb947236af14bac42cb623c2fa63c7af06a6b600edcfcd16edd1555f8"
    sha256 cellar: :any,                 catalina:      "e2463472b47d1482785708797282e85f4f8a65b6aae95770bcf2efbfd949c69d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f70f0225dbc3ac4ac64736ab97d4db880940756524735bf71f4854537e0d10e0"
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
