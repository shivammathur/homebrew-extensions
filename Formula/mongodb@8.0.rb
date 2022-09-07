# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "78f5cebda5764d48d1cf5fee9b34ebdec634f4e8a60d3b58efa32f83bcf1c196"
    sha256 cellar: :any,                 arm64_big_sur:  "1dc23da82b6434858d0de320f619ecf48821c748c16db6bc70267f7b18dab007"
    sha256 cellar: :any,                 monterey:       "1fbf7cf5800168c38f75bcba7e84316e33b8e7f3cba63ba47abe8dfcff83caf5"
    sha256 cellar: :any,                 big_sur:        "6feed4dc2f67e10170801c8c32b86bbe498711b78da9d35533813c102615f918"
    sha256 cellar: :any,                 catalina:       "e429fdbdf048b725a98ccbd4975ebc2fd4de9d811234888c19029128851c254c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3adb0e999cedc1d05c1df55732300236d9ca8e41172afa6f4993559d114fe0f1"
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
