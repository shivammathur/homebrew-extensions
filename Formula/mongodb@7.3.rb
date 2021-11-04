# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "9b7ae6c65bfa9cbee3b99e157f98c36b05bfc0bbeb41808672bb3cb06fa4cd30"
    sha256 cellar: :any,                 big_sur:       "26d7a1b3f919ab1161b3664ec6d5dec12c147003b249f319547d8ce1a45d3f41"
    sha256 cellar: :any,                 catalina:      "5aa2d64738613f07992a12af31eaac0d5b743ae1043a28272382f110025d3494"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "362c3718afd92f4e646f3ac07cdc4eab8d97ebb48c4a092686656df3b0d39152"
  end

  depends_on "icu4c"
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
