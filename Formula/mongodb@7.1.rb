# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT71 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "44ff0134d149f705256f72e04a44db2ba160cb9a783d6c5ce1a1c7d6050517ad"
    sha256 cellar: :any,                 arm64_monterey: "6561c8ba1f0de096eec88dcf50771dd143c88d0bf813cd3692022e98149c76b6"
    sha256 cellar: :any,                 arm64_big_sur:  "3b0814015f10d1a223f45fdfff584f1ed70684a71d9e4dac1812d055761bff61"
    sha256 cellar: :any,                 ventura:        "10ce3f10ae37d6d9029ab103681bc45c23b9fb011c30c7809de7d3b400cef29e"
    sha256 cellar: :any,                 monterey:       "8b6a5f42080c6159bc588faca2b2baaaa0be176fd6e3ab48c1a4f8767481e057"
    sha256 cellar: :any,                 big_sur:        "544b98eaf7609db30d764b1f8809233818d0250b193e9fcb188b046a15a3f1a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6853578102383228ec3fda06e4078f76f06bd56bff186eef2bb93a6be10153f4"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
