# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3f1046783a6034d8599fbc07574d25a166f5caebfcf0143a1a25e12a65799160"
    sha256 cellar: :any,                 arm64_ventura:  "a8cd3530f8623146784445be2d39410953a72cef5ba2be05942a51fcc8502ba9"
    sha256 cellar: :any,                 arm64_monterey: "ba3e03390d10027c857de1e3484806c62710d61823585a0b365443bc5f0d8718"
    sha256 cellar: :any,                 ventura:        "dbd13b7c98d43ffa2eb5b6799e542fbd293a6eea762a963d41a2c778181e1a3b"
    sha256 cellar: :any,                 monterey:       "50a2ee3e8031f38a0f28c0a9dffaa61b065f553169c41770f564b5d3966ab488"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7673769e507d553c081ab6c996492d954d465370f0b89b574d2dc91f52ca0df1"
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
