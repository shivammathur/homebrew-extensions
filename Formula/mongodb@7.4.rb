# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.2.tgz"
  sha256 "d05fb9ac9846d1ea1cf54e918d2f94f07682ea1e5d181c1a4a756313e0cefa2a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a4708a3367c34c56f65e3a419ce1b0106c6e9c6b8690aa167fe34c829d527008"
    sha256 cellar: :any,                 arm64_big_sur:  "763b91b86d46b53dca30d167c3c20726fd5ff6cb8b66314086d1bdbf13b6c491"
    sha256 cellar: :any,                 ventura:        "c78ebd9fb2c2590adf6353b13807fbd9350ed8718db81d1c2aaa08cea8ed2acc"
    sha256 cellar: :any,                 monterey:       "f8d1fe41d89bc826a229e5952680cc3177c4ad00234949f9e4316d5642122f96"
    sha256 cellar: :any,                 big_sur:        "608694c98c7bac8e9637cd7c748f2260a042064910fee376fe392869bfe210ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e5eb6c306994488b20a9a3d204dfaf3e9bce36d3bbb4c244fe07ca8bfca2f55"
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
