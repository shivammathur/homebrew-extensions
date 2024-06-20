# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.3.tgz"
  sha256 "a9e17b024971b78c896413b46722444e5c0d004e3de271490c9d3d55e34268e9"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "cb04bdc49bc1478f5ac016da6bbdbb3024d6878c7b3a75e6223a2f3268d27b43"
    sha256 cellar: :any,                 arm64_ventura:  "99eac5132e0a7966979db228251f691d52baa7173f9c41d4f46e13c796110443"
    sha256 cellar: :any,                 arm64_monterey: "d749d4cd0499e6c53e9c2e646a41b3cef5ecfa6cb3bc6007940422b782ada626"
    sha256 cellar: :any,                 ventura:        "a9e0859da03164801fea74c8154a7fcde58413a02af48f50bc46a00863fec5e1"
    sha256 cellar: :any,                 monterey:       "08aa820d604a2fec47d2d3dec5ac978296c4b629c3889388529f25ac2b12ca1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9fce4dc7f0fb323671141c3185144a012a1ddcc3eed25e12991c0377997b0c17"
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
