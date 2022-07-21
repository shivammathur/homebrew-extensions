# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c51fd86e28ed50858f23cfcdcc7755bffae0e4bfc896b91bbc9b2b3a3613acbc"
    sha256 cellar: :any,                 big_sur:       "eaa2b7921b5668973ab4d870d744df5c67d10777a3ffffd9a1cf556c6b581328"
    sha256 cellar: :any,                 catalina:      "c226f8f7ef879ef280592ce96272c68af3009c1063d9604d7ae49f541c5ac139"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0eb865d526c1766598741662d39053e926d22097b4ae3c79cb2d62fef575aa7b"
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
