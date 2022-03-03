# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "27fbcebea385fe2300db7cfe47f7ca674a6e751c05f4e80731cd8b0250382c42"
    sha256 cellar: :any,                 big_sur:       "cb3d35bc060a0da215e7e91e1221c32f943e8846000dcc6942f29d6465dffd4a"
    sha256 cellar: :any,                 catalina:      "f633849bb9b47827e0a747501d50e7bdaffe038b80c96588025a201c4891f171"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7a78d2fc6da32dd04bf30d471dceaf2afe918a910fbe2a213f7cf272a3985e5"
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
