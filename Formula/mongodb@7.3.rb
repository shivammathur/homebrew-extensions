# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7b97b4f8586cbd73c423addf953a24b228e6a50097f6262688b92e77e17889f8"
    sha256 cellar: :any,                 big_sur:       "a2a89c0f7f951c8d616a9ebba1380f6a6a6ddd9a08e23dc17724592a31318778"
    sha256 cellar: :any,                 catalina:      "1a9fb6dc9c7c9409ac9615442543c4ffee636cadcabc4162e76fb0c56238ade1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "485a9c8028d34e486152660f2452d8dc5479ce37b903295fa953d1a16d0ec011"
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
