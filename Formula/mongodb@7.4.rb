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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7b864004f1a8a239c180158a5f161c8fd68f47a7d5ea1cac2caf03adda0a7474"
    sha256 cellar: :any,                 big_sur:       "726a6b96b9bc2c18c1c0600a82dc591935fb53095ee01594e0c4ab1df405c827"
    sha256 cellar: :any,                 catalina:      "dedf9bee8f0e64cdac736367ef25b135ac98896ae87955550a9105fc627c7111"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02879f106ec016be675f112e2f61e7cbf30afae1edda7e93ec3bae18b5fefa4b"
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
