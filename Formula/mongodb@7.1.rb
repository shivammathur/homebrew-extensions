# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.10.0.tgz"
  sha256 "8033dce1a5a5139a4bda690c15c2c98beb18c996429da6a17796dd0c4fc26a73"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "067c66da5a4fe8e485691a731e9b3d2dbc1a8da645d18cbb5a78a38f99e16059"
    sha256                               big_sur:       "6b4b8a2393abd2af4362b1bd2289ad1952e04cf87d2289145110c7efbf2faa7b"
    sha256                               catalina:      "24c64a8817aca0d7a8a47e843126f12d1ff486ce677024030b1cb9a4461f119b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca03926eec674d37cff618f51251e5a6bd40fe57d650946001cd2ff31bb7c116"
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
