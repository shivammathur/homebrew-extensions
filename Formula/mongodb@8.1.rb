# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "3db1af9d46ca0de1029f4e96a22d96d667d44df0dbcaa61b78822b0e3d859a63"
    sha256 cellar: :any,                 big_sur:       "0f7b4a3ac28cae24f762a33329ecc4eb051ce226120be0dba2fd60f280851d2e"
    sha256 cellar: :any,                 catalina:      "ccfaab2dd4defc38c191af013aacb9149eaddc39fb4bfcbdf9c5f97fa93df490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d65b11272392cf3ae29d3895e2b76c162fc9f138bed8c2fa2d96118e15ef1210"
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
