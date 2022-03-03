# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "14b1ff3b520ca2279e5de8ea3e1eb2d7fe8fa2dd07ff530522e8226391bba879"
    sha256 cellar: :any,                 big_sur:       "31b485acfbd0725de622ae68da3b0fca873f69f0c909846b5c3b51c4ddf128c7"
    sha256 cellar: :any,                 catalina:      "64819cabe30c5e8e6cacb71d474656cf2331564f1b77ee39e126743545cd71e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de2fa2eeb702ba101b8c5ee900e547952645f3c1b3347297918b7fa02e9b7755"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
