# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "97545260894ffc7bea1fd65a9ae6ab154a89bab4044b0df176d15770ff2a705d"
    sha256 cellar: :any,                 arm64_big_sur:  "a633c5d9b6064f3cce6e60a47992d3a4c9ce0de0195594d8a5f284e92cf34393"
    sha256 cellar: :any,                 ventura:        "8e2d4aaf60fc3d4420a923855ea4898fce7cdb3b3931d1a79a3923ab4091cd53"
    sha256 cellar: :any,                 monterey:       "8db9cb945f72a1a7532cd8fb7cbd945671b2932c78cee39d3e58b47a0e51c531"
    sha256 cellar: :any,                 big_sur:        "250b1dc8185e089353504226df1c3fdacb6b2a391029b7d674faa1ddb4bdcd21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0614b8e0146f6e149364c6dde0b279c3cad535da25c69bd78ca9a9254f5bfad"
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
