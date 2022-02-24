# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "86a16184c32badf87854227fcb8bc410289569e96d544be83f6da55d7e388a8c"
    sha256 cellar: :any,                 big_sur:       "8f597f9d7dcf8c3dd9a85ec64de23e48996c775cf866436b3148f1bac3057db0"
    sha256 cellar: :any,                 catalina:      "1e575d9379e2ef6ac69772a075a503eef59633e2ac9ae97be2fcd1e9b3409eea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94b5cef70f341a0dc9dbbee9e2f8f8f99c7fe4346e193b007427132b36ce5540"
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
