# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "518d8380592efd87d31ee695c0a6622b932142d3fd97a1d55fe7f81cc5c9aa04"
    sha256 cellar: :any,                 big_sur:       "b7e718b47e3e8e251846cb4fda84d5690de486d897267fa932fe10c95f8ea9d5"
    sha256 cellar: :any,                 catalina:      "5865257e55d31db52d9cc3d5ed9ed608f0c292b7bb3fb6d5c461dbc23d906626"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "701c1906eade6794f6745698d7475598f36a15d9b8a863c49dda5dafd9d70366"
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
