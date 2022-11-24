# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "61c551ba429dff66a6c84b2bd5d884732e9a0e9d52423863cc48b21da9fd1ab3"
    sha256 cellar: :any,                 arm64_big_sur:  "d87284519901d3bb029184044cdc2bfeea527dde2fea85bb206e1ab1611bbc2c"
    sha256 cellar: :any,                 monterey:       "319a24fb8e4a63551a2f5f5c630cfedf03eb0b24449d5b50dd91b0b81afa036c"
    sha256 cellar: :any,                 big_sur:        "2368512e494a53c22fda33320f195778c7fc3e7c57bb549c26ea8eecbb2bfa54"
    sha256 cellar: :any,                 catalina:       "2c67604d3d196ac3940a6c61f21ee739cc4015500401ceb9eac0b4dfc48154ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8242ba1eb393aa83f511b6ae7c804c4f410fea25f5163a7fd06659c09fc3487"
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
