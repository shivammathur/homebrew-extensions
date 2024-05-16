# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.0.tgz"
  sha256 "2bbe89825196676e8932c87f0595922e2b1bb18a6f982ee5f37ebdc447b14d10"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "66e634728cfbfe8274e9a5a9cb015e0f9ece285021f3ca5773bf6e384bc851ec"
    sha256 cellar: :any,                 arm64_ventura:  "3cf720b536dac8b3f310c6ac99cb5e86bf11dc210dd02f93b7b726b662d78c39"
    sha256 cellar: :any,                 arm64_monterey: "c7b30316231c45c0802c1421e5833434d0db11999b5c0dbd4c534494ae763ae5"
    sha256 cellar: :any,                 ventura:        "32e1bd3de3df38270d8f2fd588b55cf1eedeac56ff31d67c4586c644d68bf635"
    sha256 cellar: :any,                 monterey:       "5bc4ff8c1a91d68949719c5718a394e44d6478e599852df57037f8ce6d337479"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55288bab3ab6a7e055e10c955cd90bed754baeb5af5053aae17d7ee38e497fd3"
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
