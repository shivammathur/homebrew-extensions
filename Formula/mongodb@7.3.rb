# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "263dad5861b62069eb7a4a30c7469597a4f0df6a6e2e6db81fd63c5c0eda9be2"
    sha256 cellar: :any,                 big_sur:       "d551a110b48c8314b363795f0405ac3b78e33820bdbe0ba99328267d7fee013a"
    sha256 cellar: :any,                 catalina:      "1ca50282dffd37f1275870a9e8fa6f72b6d1c31a06b96533ccf3d3b2b5bba0d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d27ec953c6505b748b1c80cce95b5df838a915e340f38801dfd632aba48fef1"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
