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
    sha256 cellar: :any,                 arm64_monterey: "266e9e3493eae5c5677c9b015a10a9b26aa1484af8f62df975735fac22324d06"
    sha256 cellar: :any,                 arm64_big_sur:  "4ac34ad646ae9866c715fb1dcf1fdc5d6d7e5a32e32ebf5247812733a9496115"
    sha256 cellar: :any,                 ventura:        "7df26e9577a8910f83b0d67838c2202ccdb68b8afd9314cc9adb0c4e9b237fcd"
    sha256 cellar: :any,                 monterey:       "4b35ae324f397e818029b9ecbc57b7129e9cae74f3be172d70ebfeee78c5b956"
    sha256 cellar: :any,                 big_sur:        "88bd84476a4e2c130e989f279b031d5e70a997431a59b922fa567930e1452107"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4dc59b58b350b52388d6b769444612de8d5d154d08cd71e2ba7740fbcef571d"
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
