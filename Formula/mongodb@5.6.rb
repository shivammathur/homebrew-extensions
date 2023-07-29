# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9e8cedb8d72fac143a1e335ddeb04ce7d2b5eef8c2e5fc7f700ead62e1dd654d"
    sha256 cellar: :any,                 arm64_big_sur:  "26e13e594b1fcbca8f9722fe09fb8dad029efb67eaefdb30cc5e685388985cdc"
    sha256 cellar: :any,                 ventura:        "fc72b93a16deb5aa91114c653d5df59f3f6ff4e37a34c65802ee688e05fe7a13"
    sha256 cellar: :any,                 monterey:       "c32d55e3481d4e57a388cfbac10150189b45e5e231dff6658c3f16fea9b4f7e4"
    sha256 cellar: :any,                 big_sur:        "193ab3fed009aefe03873c7792f5a9206bba58bd2773d399e85ab56cc0bcf61b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8f7ca67d93faee1839130607583dc637358ceee4277a03bb53b95f48cd18df7"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"

  uses_from_macos "zlib"

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
