# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "911ffd6f4588a74908ceeaff53752a79ffacc076710573febdee11cba70c97ab"
    sha256 cellar: :any,                 arm64_big_sur:  "5d7e25a4baa8b0a517e567635f0636e2891d970b90c9ac0b43d32a55d7592786"
    sha256 cellar: :any,                 ventura:        "ee6afda6a3fa5f2fef7c7eef599203a226a91c13aacfd03e6d3ecad522509931"
    sha256 cellar: :any,                 monterey:       "3dbed11a55d10b1dce62d1eee67a777121f47279fa4f25a8e3baa3be6742eb31"
    sha256 cellar: :any,                 big_sur:        "c1aed8d39164480163ccbeeeaea697f95b256f805cd447a590c08acfbc9e1bbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31b185f78e07726b4df5c7e6f79a60ee1255ee8942fb028cdec722fd3227b6e4"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
