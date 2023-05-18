# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3c8ce4d2d805092cacad81ff449a8fda5f879704c612027b74b1a994a92d06ef"
    sha256 cellar: :any,                 arm64_big_sur:  "00ecd2c78542c4b97a2832b9e720ee2b3968c793ba0620bf7bd6e10dc865f23e"
    sha256 cellar: :any,                 ventura:        "ed5908e2bc0b6b4885bc840cf3ebde146e424b36143f36201478f9fcd9f14a9d"
    sha256 cellar: :any,                 monterey:       "b0d28c7f3dbd36b906622e181b370185e7675479638f2c77c1a66e8deeb71429"
    sha256 cellar: :any,                 big_sur:        "f98542e18869dead4ade5e3efa7c007c86e42a2326afe3724e1b1d4b570f9b12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6263466be56721267171f08d8ee6c52aec4db1c8319775e6a19a85578f86467b"
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
