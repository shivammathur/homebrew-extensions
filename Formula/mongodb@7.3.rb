# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e9ed0626b90b16c639afefc167ab90f760bed8273aaca69fd9299eb3cddd7bba"
    sha256 cellar: :any,                 arm64_big_sur:  "0ed0172aa01aabf0cf61eaa305edfe5b8a2877abaf58d3302923a3af60d20aa9"
    sha256 cellar: :any,                 monterey:       "6a34646d7869935827182fa1e28568b7f693c94a7a0d026e9813505bd22d51c4"
    sha256 cellar: :any,                 big_sur:        "eb4f5375b898b0990a7d2886d9ae292d08c9051b86e3d0d317409118ebc04056"
    sha256 cellar: :any,                 catalina:       "4c2aa2b0ab38ecda3846a8d1c1a2985bf88b454d71393b74ebcc8d8feb6b4b03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2f30fec5e067d1afbec0d4f7c123de8ed246d94679985fcfd5998c8dad5d3a76"
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
