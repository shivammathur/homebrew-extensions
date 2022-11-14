# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "086fbfdb62d29c4fffdc80384dcb47026c81947db15a52d64f94ae1503f4da63"
    sha256 cellar: :any,                 arm64_big_sur:  "e3e55f64dc79722d240ca9dcbf65f61dc9c21a4478d1881c623f7266426ab527"
    sha256 cellar: :any,                 monterey:       "6ecd786c157263b3e3c3f9dd2268295288e0be80e16e626fd133665987b0384a"
    sha256 cellar: :any,                 big_sur:        "26cad0b72799646610aea3ce5f74a05cba068a27d80eaecdd97717199bd1cc71"
    sha256 cellar: :any,                 catalina:       "478bb150a2321d399c64b529ad9a9e597a0160e91291b24566bf5c35e67ab5a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f368b64c0b7c61a975f01ecb889be842423e7bae028c37de69cc21bcec39419f"
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
