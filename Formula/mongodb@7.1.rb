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
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1487ba3c8f5e496caf58575120b4ee540e62c0432cca05080dd4640a0d6b72b1"
    sha256 cellar: :any,                 big_sur:       "8dfbcd429d5afc2c6fa197235b9fb04da1779b9ff2e4ec1cb8fcfa0dd188b215"
    sha256 cellar: :any,                 catalina:      "0e8a0056c7ba8ccfdff9542e529fb35587a40f05501f691306fe02e09411f750"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33723f91bcbefa1cba029863fa5b6c34eae9efb1fff3f133138876087db12d77"
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
