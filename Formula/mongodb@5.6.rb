# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1a48155f878bc48d8e179461d4dabd690484423a31e338692c918681a7b69bb6"
    sha256 cellar: :any,                 big_sur:       "067609ab597cbc82d0dde8076cffef5a110d1f495ee9f54ff046b6cc444605bc"
    sha256 cellar: :any,                 catalina:      "95643ce7414d5657c07c57f04ae76a68349bdf7a39dbdcd307aba909b2c2ad6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb3fa2c806e00838fd78a7b3de3c874ed8dc63ec3a4efaefd83ab6724a27a21b"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"

  uses_from_macos "zlib"

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
