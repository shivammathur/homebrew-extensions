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
    rebuild 1
    sha256                               arm64_big_sur: "8d992357e6bb07cabf3d1fd355732066534cf4d3b783a27dc9af1d17bfb16ac2"
    sha256                               big_sur:       "5fd4b8ed4a0f60745b03d71dd6372e97308e9b1f437c57b3ba8f90be2f593068"
    sha256                               catalina:      "ee3e4b2cf4b833aa4da295121a2371b82888e373f7236a5a77f73199075def49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1eb814d7e61f77bdb4eabd5a45134d5652a8ba72277ff2637c2e837de2c09d2"
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
