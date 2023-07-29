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
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "3c95def6097284392753531dc1e81a627d6085c64d480fc740064ba6379342f8"
    sha256 cellar: :any,                 arm64_big_sur:  "079d3b9e857d41b0bddba0d47061308962666995122911aa5bca615af7570fc4"
    sha256 cellar: :any,                 ventura:        "6d751c4685f184f64d0874a57b663379497c7846604bca58404ba8be5088037e"
    sha256 cellar: :any,                 monterey:       "a6719e6983f12f2ca3f222513028b159c5aa7e0744f1cdbf0104954da5baa413"
    sha256 cellar: :any,                 big_sur:        "d27a0040f7723d1430b68e54495d08c5e4a10ea0641d3c8b0b71b75f83001cf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7724172c20575b834f0c61fcc884fd8472973adbb9240e6627b4af0fef22ebdb"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
