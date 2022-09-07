# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f042cf8d5bdc07f43b8c31e290deeedb5d48e9283b58ab69a0e2a5967146a194"
    sha256 cellar: :any,                 arm64_big_sur:  "6aea629d0a0b9e2d4a0f41518096f566f8e59a16b57b8aaffc712e66a974d0f7"
    sha256 cellar: :any,                 monterey:       "f70cfbec66ad8e6f1e1095c9d4a4a1113e4c87523fc01daefca291f373b8c135"
    sha256 cellar: :any,                 big_sur:        "df3b42d43b25aea7a9a2ce33e342ad6845effb7a50c4c111b783023ea33b71dc"
    sha256 cellar: :any,                 catalina:       "47d30730a9b8ca2c893e1959afeba5263c1ee23d8e08a3949bc90c80c3c244c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c942f88bdc37bcfa462b44ce4a7f348be0c16d65f061bac9790ed4ee89dead2"
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
