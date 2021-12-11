# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "4e402b911f932acc1afcc9ebafbcee27dda9f88df36a59e548f600861cbae9bd"
    sha256 cellar: :any,                 big_sur:       "0cc4b6d7c7fe9df58ce82e6b3f7f61db924b770776e11e46968a4730cd329d3b"
    sha256 cellar: :any,                 catalina:      "9dc60c2cbfc2e9afcdc7cb25b18d3ee3c870b79893ce5cae083d3654bcd62336"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "378cd175ba59edc113c9749cc4f33fbbcda513ec731d332a7631f4fb0f24ef91"
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
