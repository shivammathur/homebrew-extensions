# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "0c966903d00d2322cd691d7bd18b3edff593be96a49ac6ede9104e85b4ed7144"
    sha256 cellar: :any,                 big_sur:       "3feb786fd54d58ff9609d0d1d5727045dcbd3f3c728fe6a6e356ec945e23bbc7"
    sha256 cellar: :any,                 catalina:      "7105e04c27bc4f117cc1da16a3fbd52b9cdf8d71165df6553c9b1184f11e06b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55c7862df946288d9b3d53653f1e8344e66cd7fa4a8effc9e64b0dc1f9f06953"
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
