# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "803edde53fafaaeb61a5758c8dff369fd86eb86a70cd703f7e35ad443c964375"
    sha256 cellar: :any,                 arm64_big_sur:  "deb628a0c3dcc81fc6e621bfbc87739e06311bcd550813589bc41f7a5606184b"
    sha256 cellar: :any,                 ventura:        "85ae946dc91ed9f2ab8793a86b72b7602ef3e281bb8db9c8dc48ee8afcd4c320"
    sha256 cellar: :any,                 monterey:       "32dd980073d57eb32b899ae3d4410d8ea61c60223c0b1da7522d3bf11e84820e"
    sha256 cellar: :any,                 big_sur:        "9ae1ffe7ed4fd0ddb083fdf181f63c97588a01e56af1fb9780eeab8b989dbdd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14a41e56721feec661b4096e5689e0152c4587dedda167ade56c837206044829"
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
