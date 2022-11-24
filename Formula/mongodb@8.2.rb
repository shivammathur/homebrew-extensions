# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "12fd849eea6a14ee8698f0c73d6edf48784ec99d26baeba54d9683c386478571"
    sha256 cellar: :any,                 arm64_big_sur:  "10bdbd9e672a56cfb196d2792236bcc8c604cd1ca448c1d965626d5406b916be"
    sha256 cellar: :any,                 monterey:       "c25792b51f922eda9e86760f9feed3305ad22280fb5b2a56b706da0ece907a4e"
    sha256 cellar: :any,                 big_sur:        "2f95c451d742f261ee9a9b587ad81abb28d0a516bfaf8fa81a0066af6f32def2"
    sha256 cellar: :any,                 catalina:       "9ee51acb64e04afcb2ffb449a777192fbf8571cb0b2f489b27235bbd36bdaadc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "86a1e49845ef8d549b6446a67af75350f56f8d93b63d506429184b6d19e4612a"
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
