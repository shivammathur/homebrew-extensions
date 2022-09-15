# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f0ef6a952af4541725f5f8d7372d7c3d11bd9fb8e5954556f2df0a579ff5b68c"
    sha256 cellar: :any,                 arm64_big_sur:  "7b811153fdf717db302efcb59bf0cf70c6ce6b641eca49aeff8f251fec803c49"
    sha256 cellar: :any,                 monterey:       "7ae1d62500ff18049c66b3ab3753b814496fb29b6dd01ebddf3d67717b2c3004"
    sha256 cellar: :any,                 big_sur:        "b6ea9d6e0073326df375cd12b90373e3f1cca9981fabf1470db687ac3d906373"
    sha256 cellar: :any,                 catalina:       "344f0ca9dfab40ef547b958320247915ec1248ac192ed852dfb3c6c5d1d157a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e6aff5f10c7a805acd7bb1ec7dcc58e6604af3cd288645e6b2a24c74cbc5b353"
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
