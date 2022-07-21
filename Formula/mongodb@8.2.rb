# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7eb02273dcce95dba7f8abe493e97effbd9968c0e5a17f06c87219b329791e0c"
    sha256 cellar: :any,                 big_sur:       "6b77780bf432cb5ce0707f869b350ba2c02de7e6d405a4a892ee77cc0bb7f705"
    sha256 cellar: :any,                 catalina:      "954487e59ed2b01a70ac6b560e4f8a2663116f81fa2c84a3c8467ed239b0cdf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f80bbdfa3ade1e0f30caeed7e2d4700d72aafd4a107128f716322ed9e4b0c43a"
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
