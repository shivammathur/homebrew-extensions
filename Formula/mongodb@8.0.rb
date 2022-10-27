# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8425a649bab6238fa724621e857568ff9afdf069c4f8e5f8ab0fd05492d7da00"
    sha256 cellar: :any,                 arm64_big_sur:  "53e9c019556bbfd3a92d8b691980b312542dee795f7286e45554c757d5897c3c"
    sha256 cellar: :any,                 monterey:       "6fe7c440590b7288d4d4065c049b03f20544ba74dc69a967916bdeb184d40112"
    sha256 cellar: :any,                 big_sur:        "086b7583312f392f0546ed0b68ecaf39ddf513e76295a2130a04a237d5141278"
    sha256 cellar: :any,                 catalina:       "08aea60cb3057379b98af4431b8d20f93b633774eb80a0c2047d4a156bee5664"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e0888b41cdf20829acdcff222a8179cf3a5aa5e167f2aa6fe5b6f94ec70adaf"
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
