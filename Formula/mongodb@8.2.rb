# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "2bec0d407232933ba1e40f193923450162562793b667c755127c829d09ca0f08"
    sha256 cellar: :any,                 big_sur:       "2dda2e9bbc1c1231269e43b03414dec8fe0e24cf9e2b73be4ec6e0c7bc399425"
    sha256 cellar: :any,                 catalina:      "3888127bf88a00858a8a8fc13b4458957168522fb63fc73278285aa467648b3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d728e9febb6f0bb4f15af2bd6c4544b4fbcd962260f13b758d90e30830b5ddf8"
  end

  depends_on "icu4c"
  depends_on "snappy"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    inreplace "php_phongo.h" do |s|
      s.gsub! "ZEND_ACC_FINAL", "ZEND_ACC_FINAL|ZEND_ACC_NOT_SERIALIZABLE"
      s.gsub!(/ce->(un)?serialize.*/, "\\")
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
