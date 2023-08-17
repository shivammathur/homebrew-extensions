# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d3440109f71c2cac2ae7b876ba4023a6063e58fcfe0805dd253ad23b400f406d"
    sha256 cellar: :any,                 arm64_big_sur:  "7d88a229038eafb2fcf33460249a253ff4316b10db70d4e0ffaca341cbc88691"
    sha256 cellar: :any,                 ventura:        "7a6b6e9a0e5bbb6b5f583b3d3f9ab932e48a209ec09bb58dbd641a704abefc54"
    sha256 cellar: :any,                 monterey:       "041b66863536191a12a1e0de86872edd6df9d804a8ffc732af591eefa06bc6dd"
    sha256 cellar: :any,                 big_sur:        "5e3bbdc970827f6b5bd147064df6dd114f88126428383c1341cee3d8453ddf41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f86875776546a839b60da3290585ad8b964e92f6ec3e4222ddcef8ef266b87e3"
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
