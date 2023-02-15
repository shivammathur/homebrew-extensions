# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d1785009bc65dd1a42a987e4dec73cc34dfc055b54ee3d4c965931396168f829"
    sha256 cellar: :any,                 arm64_big_sur:  "ceebc742a8493d84b61053f09a1bda52492c15080a4c520174f5ebcf53c838fb"
    sha256 cellar: :any,                 monterey:       "0cdb63d4412d0ca05de850b688a0ee1512944ba851eef41e18ba9c510f0ee184"
    sha256 cellar: :any,                 big_sur:        "6932d030469f66c32b083726e0843a354c5783fbea3eb09ff275004d1295d56a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b12e1fd74e198f9b779fcfa59c5c0af55711f5351ef3443cff985ef60543daa"
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
