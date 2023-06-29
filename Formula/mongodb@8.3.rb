# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "11a8579f285112882481cbf1e45f9f758aaa1b1958a0aa67a5521dbc4dc012a6"
    sha256 cellar: :any,                 arm64_big_sur:  "bb2bbf0abc4b84fa1c3661dc6baf6c293ae1f468dbb5cd68efeb67e8c2390269"
    sha256 cellar: :any,                 ventura:        "d0f7878fd3b8dad7f3226d6d14a2b28adebf5cb7b189aa7bddf83e4ead435521"
    sha256 cellar: :any,                 monterey:       "e670192e98ae7bc7c76e8f5373158aa4656e535162fd86e8c5ae0b6a9b5c36ca"
    sha256 cellar: :any,                 big_sur:        "9818e1274143d9f1c7d3e8fbddc8a4b5b2cab0d0d4e5c15a64e3a100834faddc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "131507d7b1ab592431c4f6515df444696b7cf2e718f273d015e1ac2e89c547ef"
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
