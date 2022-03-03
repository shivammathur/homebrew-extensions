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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "73df948e444bac444134ce0f82cf84a0356f38df1f68580ec24652a8103ec349"
    sha256 cellar: :any,                 big_sur:       "b154aef44ded3f7b5fe5086e2192904262e30142dd4836311f80e6c52c298fc4"
    sha256 cellar: :any,                 catalina:      "7979bbfd0cf1f9b74468c5baa136ae0eb1d19470ff1aa57bff0cff20d4f81943"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9da5447e553229e429d59d77a63cb802802aa301b9a83559069771778bd668ea"
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
