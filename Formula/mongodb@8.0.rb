# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ac79990f4c99a5918a62adaf62c1bb6bdc0ca82cfa853c9991c9743a13ede9bc"
    sha256 cellar: :any,                 arm64_big_sur:  "cc8639ec4c1c8b0b9359dc5d0f54a8de402f7e59ca456de87734e5704b1d8487"
    sha256 cellar: :any,                 ventura:        "04ba569534b87cc498edc396fc259b7b67333e0f86b82c6588fcf9bc1bae142f"
    sha256 cellar: :any,                 monterey:       "071363e68ed6cf84b5709a6f1a57ad039b7b36301216098d3b994d498d4602ca"
    sha256 cellar: :any,                 big_sur:        "a1b05398de46e27e73c0963eeeba16826fb2ec1550a4860a87c80390c0f49761"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c57133162100ccacbb5808ff3588bf95388fd618734cf19fa3a93b9b0b027f13"
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
