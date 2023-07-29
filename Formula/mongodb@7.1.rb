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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "90af8e992c5a4a5fa613c5280418e1592625ec405303bcc7f2cf6680398d45ec"
    sha256 cellar: :any,                 arm64_big_sur:  "332e587f3135972a46f59b8cffc80dfcd49f302a7548d93e1933d4544449dade"
    sha256 cellar: :any,                 ventura:        "bbde3d644c1bdd3b8048f10d0894d54364534c921525f4959e78aeb01d79a423"
    sha256 cellar: :any,                 monterey:       "6224e437457647599bb9c597f664c53892d74c76cd88ce53d508fc02ae51dee5"
    sha256 cellar: :any,                 big_sur:        "bdf3e889597c6c2321b4356259905bd1bffb24452919b9105d64dab3f0a2093f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26557dc6d479d8e1a4797ee4523d3dee16360ec966b774c1b39feb7c8cfc0fed"
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
