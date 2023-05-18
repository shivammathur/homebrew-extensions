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
    sha256 cellar: :any,                 arm64_monterey: "e50efda17cd8a8ae73a3de0a8cadf32282916b907f52b420f34707d5496cdfbd"
    sha256 cellar: :any,                 arm64_big_sur:  "a7e7f8c69e50bc9c1e98b467a83c6f5b2ae1204fda39fa1de56217a98da2c320"
    sha256 cellar: :any,                 ventura:        "cc7dd48ad48cf3f7d4dafe46df5d07da4aa21c18de33dc23354dc861e8e04e37"
    sha256 cellar: :any,                 monterey:       "21add156b202c1dc1d290f0365210fbc0282bac4488131ddeaf6e5d88e43129a"
    sha256 cellar: :any,                 big_sur:        "f5516f9a8ab4fa30a4dd8a256ea0f37c0256c258d91fb3ac22f6a8263c5e5b45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cc313fdc307972412c5cb6d3c23e32d1df992e36d1e33ebc81366bc71fc9d87c"
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
