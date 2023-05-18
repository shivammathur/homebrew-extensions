# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9072937396ee5ed990479328437293578ac090446ed18cfd0f6f9862f19963ce"
    sha256 cellar: :any,                 arm64_big_sur:  "ad748b2e1943fab9492a0703be2330c7a63c5025602ff84f3fe0e2d3e54782ab"
    sha256 cellar: :any,                 ventura:        "27b71e916c0b613798481dbc2ce3c16692892def8d99b7e6eec9e529c5a0ee61"
    sha256 cellar: :any,                 monterey:       "69930af0e9625eac4b64d85b476527867a9ff226b0abbc3aa7c10d25c3a4aefb"
    sha256 cellar: :any,                 big_sur:        "09c73f6fbe41ab220a55e851e3ee781f0b2b995fa402b75458e74a550669be51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8c6ecddbd91f3ea73fb9a1ee15b5cc0f6f6a690c40f7e253912813ed87d19bd3"
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
