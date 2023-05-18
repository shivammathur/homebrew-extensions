# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b158c5bca20c6f8ac59d1d83e942c011f494c1c5d7a8c0390adf55af81c17836"
    sha256 cellar: :any,                 arm64_big_sur:  "4782e30a23bbf6e049265e94cd15ce2071410a6aef77d81fb5b246cc2bc0ccfc"
    sha256 cellar: :any,                 ventura:        "22b4448b5dfd71a47247621ce2e3548db46c129b6badc0d110388e891b212cf2"
    sha256 cellar: :any,                 monterey:       "710f4613cb587b4a7b706f6b038e7c1167c06836536474a39df5fa5b1c8f56ae"
    sha256 cellar: :any,                 big_sur:        "da47d5da04417f18440d0cea446e60e8ed162f673d7f6be0f4288db1269093b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "05c67bf0400d4eafd0a3172c4343df931d5d80a7a1db9f0c4d2045063ec69b14"
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
