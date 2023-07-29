# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "321e8c86047d5356ae0ab632350297c26670951555fc9a2aa09a3820b795b8b3"
    sha256 cellar: :any,                 arm64_big_sur:  "e3dc5917637269ca86b92b7de39cb2ee0edb31e4c1f1ff8ddf1fa1e6f8536e78"
    sha256 cellar: :any,                 ventura:        "3eb8c1390447ce5dea122f1d8d79042c25741abaacfdbcae15b32210a8adddd7"
    sha256 cellar: :any,                 monterey:       "22c49861c2817812f012ea2450a902ab1604cd788ac75bc6cf3f4f1edbb3871f"
    sha256 cellar: :any,                 big_sur:        "51b30ac854f83b501e31cdd731006b96312cc85211f4a4c0f36c6ba6f1ca3b57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f6602977caf1f3121112ce3ed880a0e86dd608efd4534c073e868873983d3c7b"
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
