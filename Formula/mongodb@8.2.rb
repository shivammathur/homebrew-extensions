# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ba7c124fbf52c9b6aa277ce4061fcd67d7c0e563a689125b446499fddbe45ea3"
    sha256 cellar: :any,                 arm64_big_sur:  "7e9a5083a37b21bd28216fb0af344a24ad04557d119e95351111a2fbf14eb2cf"
    sha256 cellar: :any,                 monterey:       "715b4b778c2703ec72d32799b4113cdea0586663aad95a56310cd91758088058"
    sha256 cellar: :any,                 big_sur:        "e649682893f0c480c6b40b52924f5bd43707e7a6529dfeac862a5be80eb250b0"
    sha256 cellar: :any,                 catalina:       "89d7308cdcb202bba0717bbfb39e246d28913fdbf52d780b7e3bf3e7aeb27cb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e85a2c3779fe11ef4c1909de967221ef14d056a826c209ba074c659bf8ff5fa5"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
