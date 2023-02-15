# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "72bcd02cd30d0f09f871be8fe465ffab1335241e351d96e5aa49956828f7497d"
    sha256 cellar: :any,                 arm64_big_sur:  "830cf88449e12ef6523eb879a038e7527284ed81f992dc1a0a2d1191af3a49eb"
    sha256 cellar: :any,                 monterey:       "a234be845b1f7c7db811f8f8b5dfff485f6dcb83bdd05e289f2966158fddc7ea"
    sha256 cellar: :any,                 big_sur:        "c4eda1d9ecbdf821050baa5f51600468ca5f363b8d9c956c1b111dff582ec11b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fcb5d7c0c5e6356f0e1e44e87d7feb59190ad8a87c1c400553d80817e1d59243"
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
