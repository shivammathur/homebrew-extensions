# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "22aa2dad5877636ae2e15d02d87c97beeac79a055276078c7a230d1b4f3ab154"
    sha256 cellar: :any,                 arm64_big_sur:  "79ac16c5bc812126d62eb3147d2620b1878de9358bc37d346955c1c9165b3767"
    sha256 cellar: :any,                 ventura:        "1e2276a58a291f8a85945a5df9a1db5866572401b35913b4cfa357e87adbe4ef"
    sha256 cellar: :any,                 monterey:       "7054338d0375b8441af7e861ad5b9e324f0b626277c8e44f0de5d1d335066b8f"
    sha256 cellar: :any,                 big_sur:        "6825ba89a77cbab2e5229dce99a76e7f8c729a4ec0ebeb68ae41c68f4c34b587"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7881b9f23c984ac85eba0545d0a8987ef738983b1881e3bf8b73596153c3e2de"
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
