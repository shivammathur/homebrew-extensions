# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "ceca2a7a660aa004ab39b3881954b4b9ec533ecc63bd2fbb84ab67a4453b1d0c"
    sha256 big_sur:       "bbec9bad8b1d36fa64d90096eef284ab12f415b4f7a2e0085f572a8ace093e75"
    sha256 catalina:      "2124d4fef94bc67952a261fca70f9556d1d6b6978dfca2e25f409f11991bed40"
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
