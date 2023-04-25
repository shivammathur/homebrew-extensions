# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.2.tgz"
  sha256 "d05fb9ac9846d1ea1cf54e918d2f94f07682ea1e5d181c1a4a756313e0cefa2a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "485d4d751d17b516ebbffef1de6456cbc8b767bf9ca460c43636efe6b02c85d8"
    sha256 cellar: :any,                 arm64_big_sur:  "0beb4a470520799bf035ab08c83651cea8f93f1f6fcc53fe9179a67ca899dba5"
    sha256 cellar: :any,                 monterey:       "e87f07d8a7d0fad25ee3662b696f74d020ccc2087d54347ba8b388c56791288a"
    sha256 cellar: :any,                 big_sur:        "f923067d6dab9941f2a089d61d4f352a0eddc21ed3535ce8f39993f5548503db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "212c15273e64bcc63376954efef2254a64468cefb2e6fd67bf5c06ee4212acea"
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
