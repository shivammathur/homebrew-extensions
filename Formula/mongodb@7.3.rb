# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "83121efd5f70856358eaae46e1a8642132791e3301385718e1937421d9f00967"
    sha256 cellar: :any,                 big_sur:       "067a8174fc2a8f3148eb29e24476261f2c970a60c22cdd71d6b9a02055db0a1f"
    sha256 cellar: :any,                 catalina:      "042d0fb31127b2ff6efff4a0ea71ce57e4091c73ebc89223f1d1b793557c31e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75d5b69ed3ac2074b76e3ba85682492347bd1630115c03a0957f26b124bd4c87"
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
