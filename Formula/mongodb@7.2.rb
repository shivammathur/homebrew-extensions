# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "503e5a9fca2bc9243fbbbfeeee4f31b8a40a5eb1e05398547af1abd7f8181e52"
    sha256 cellar: :any,                 big_sur:       "e21f46325691b3a3ecc4ffe66287f3d98353db14dab13f387a383214f4997b21"
    sha256 cellar: :any,                 catalina:      "dfd6534d681758b772ebdb4dd8b97b149d244673fa589faebfa8791520955ec7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ebc4d054e78a127608c60b2c024594b8a4f5447df0748f70638580657aa77749"
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
