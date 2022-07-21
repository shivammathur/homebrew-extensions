# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "cdebbb1e03bfa46f120c0720e4d3a8d6fbe7057444d60e12a8229fd6bbd8f55e"
    sha256 cellar: :any,                 arm64_big_sur:  "30e2afcaa34df192fdabb6eef339f43442b2e098a6d57c142817c5bcd27cb46b"
    sha256 cellar: :any,                 monterey:       "d3bfa6cd59315cf9008842022da2150ee139c22e9b028003725796d61b445323"
    sha256 cellar: :any,                 big_sur:        "19e22bf7305368f11b9874b2e88a097e996843dee6b46e1a1027330d1ebf6fd8"
    sha256 cellar: :any,                 catalina:       "742f7f558e2d0ad48a79ac8caa1a78b5484262a38fb14091794b84ada4887279"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6eb2b0695445acbb4e844af2025944e4306de9bdd4b248fa10382c0914f4423"
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
