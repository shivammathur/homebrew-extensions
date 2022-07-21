# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7ff6a3ab6f600b32997c8e65f7114a59c54c1eddb28fee280f127815c50c4a22"
    sha256 cellar: :any,                 arm64_big_sur:  "b54a8576006b71653297da7ac63be2776974c610519cbdacfd34526eef2eb316"
    sha256 cellar: :any,                 monterey:       "dcca1892b6278e5948e8fa94d20f48b36d438b2278d4a470e3ffee4a54b52cfe"
    sha256 cellar: :any,                 big_sur:        "dac3239697da907ca52bad76bc9ac44922a699722260778a6ff52e4a1dcedd36"
    sha256 cellar: :any,                 catalina:       "947ef18ec6757a677bc192bb7105ccbd41f56ca90f9e5571489c89856fdc3e2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e87409bf8b15838d3807541bdec3b8fae0ab47dc79f7ba9526b4873cf7614953"
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
