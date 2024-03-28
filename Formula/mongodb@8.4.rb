# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "2577fdbb22d45e9dbbe0229c4b1aa6a8361d9343d94a9328dfc861e3a28402c0"
    sha256 cellar: :any,                 arm64_ventura:  "3153ac6bac1586b5d587297b92a4a26a0ca9efbb03faa9f5eca195a3dd3e1cb5"
    sha256 cellar: :any,                 arm64_monterey: "921474a1481ab7cca705995502d2aebac7d2c59c760dadd37612809b234b492f"
    sha256 cellar: :any,                 ventura:        "0a6f37879e3f905a88d32c558f338c5483af8b3727ca0a7d7ead8d857945e264"
    sha256 cellar: :any,                 monterey:       "fd37b833349d3045387e5e32c67c63ca97f0e090b53bdc0f03056ba57fad523d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "abc9910d77aae3a2024b25b53dd8c02dfddea20a7c30bdab5a0673524067815c"
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
