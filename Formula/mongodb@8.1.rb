# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b524a3c0c3b12fb0234b8113c5b08b67da5e329770c0d9b9904281e60a35a5ac"
    sha256 cellar: :any,                 arm64_big_sur:  "59ee57c1e1fca6c31307e75e33bf9e7ee5085da604e793281ac65623a403fa6b"
    sha256 cellar: :any,                 monterey:       "37981c0a38aee52e96fd941ff99199f2bbb6526f9115354b92ace15855c54996"
    sha256 cellar: :any,                 big_sur:        "55a656c702e079036df04ed254d5daf6bf969c07eeaef434417078782dc62765"
    sha256 cellar: :any,                 catalina:       "8b8534f6cb96a15aebe0bdb1962ba0a9389ecde8e31b26e912b34dc6edb841b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c1d26616bed94e5cf1cd71307a7a75fbf060fc5277cb41858c0668c29a3b046"
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
