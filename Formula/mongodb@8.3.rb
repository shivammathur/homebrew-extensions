# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8a6a507db854548f2c034198cdea3f5cdee5bd6d06c80ed345036137dc9bef52"
    sha256 cellar: :any,                 arm64_big_sur:  "c7f9a34a8a7c5ba7adcc27cd64efdf11409a83a6b8b8efa1f3e1c736645fdcf4"
    sha256 cellar: :any,                 ventura:        "8fe7619edee824cd15a0df98b3ec0f6354f06484f6bdd8e64d2bd171183c2651"
    sha256 cellar: :any,                 monterey:       "3b004afef8751523b2237dcfb13a721460bc93c897319d9fa8154411fa4fdbd4"
    sha256 cellar: :any,                 big_sur:        "753ae050125ef9999fb89dc61bcef583438e21d861be4e91501c5d21c3329de9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a05b3d5ad2c825b7945ef7bc8abb807d19acccc24c999d3fce198a5d8376cfc"
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
