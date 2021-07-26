# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
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
    sha256                               arm64_big_sur: "990c01df4372efc2482bb9ac6014fdad69c6fb7283320f315dc3b534d368d512"
    sha256                               big_sur:       "3f99f1a9341cbbf9b8ab4f21f6c6e4ce711d333e1845d23eb8c9a596dbc99fec"
    sha256                               catalina:      "2e40b09dcd2d3aa4d1aa1a75f2477ffed291b38957bc5d9237140ada7164f99f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "71d6d17577e75a4120ed3837112611be52d429c7d83d4b06cfd3fa4c225040e9"
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
