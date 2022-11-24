# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "23f3bbafc7f6c6d5106fec781c83c6cd22ad23c25c459944b809ef1917abbb0a"
    sha256 cellar: :any,                 arm64_big_sur:  "029382f8adb2844409b0bdb759a345fb4245f42bb78372277a1ca140bc030bed"
    sha256 cellar: :any,                 monterey:       "e1c0e24bc3287e4a714a7b413c9b93d1a74b8d7bc44d4860eee4d6ca6c88dd81"
    sha256 cellar: :any,                 big_sur:        "2e20d49eeeca9203e301c27540361510e04e400cd982180b46274d9b795b3ded"
    sha256 cellar: :any,                 catalina:       "a5f19184fd1662bddc117b2e3261243d82734313c92b1578a8274d7400278365"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c61ecb7533ce8af80090286d7737a19c6a66528e9737779267d67c4d72664ee"
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
