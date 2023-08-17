# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "335c8cf4c17c41b8b87594ec9a75d95ac32ed69548379d9bb0f81af497ccb6c2"
    sha256 cellar: :any,                 arm64_big_sur:  "5cd92ec76ab5d22d9c7dfc05b38f5dd7c6819d9becce7c108d6636c8426e9af3"
    sha256 cellar: :any,                 ventura:        "d16c0d3514092431bc51b79267c5fc8dc41591ae79df5a673ce969f910f74933"
    sha256 cellar: :any,                 monterey:       "2b8112b9c45f5dcccf53f8120ebc90738f3946858658bb1fc69982e30679ec69"
    sha256 cellar: :any,                 big_sur:        "66aaa5b22962e033b288b6e36c641bee3dc997ab30084619b73bb90e9d789bf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a838149125a8c9508d2413ceb1963c742e6a05cc382c33f32cdaa432d7fac2b6"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
