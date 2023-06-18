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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a23da0f86429de15e3392c374f1d4924339fc1fb9566cbcabd96689449bedde8"
    sha256 cellar: :any,                 arm64_big_sur:  "d3b5ec339479f70e8dfbdc10569818b2d2d185166bbe93b7ea99f01fa308b219"
    sha256 cellar: :any,                 ventura:        "2c5e70f34ae69ade70fa79bb58ecb1e1e46265c5eabff171860c9a48b7571d74"
    sha256 cellar: :any,                 monterey:       "85735f49823ddd54fd3c102653f5792b7af6f33f5ab7932417adaa72b4421aad"
    sha256 cellar: :any,                 big_sur:        "2e0f43a0ce859c49210f4b4a43ee3aa915818d9f77b6ba4d32628c3afc794727"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "287b86d80d3b75c86efa1899e00322486ca66fed95e7a3534167510a6d92aac3"
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
