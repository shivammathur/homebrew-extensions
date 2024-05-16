# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.0.tgz"
  sha256 "2bbe89825196676e8932c87f0595922e2b1bb18a6f982ee5f37ebdc447b14d10"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c4896badc77f588d0ce44447813b8f18682138b646c0e22eb74cb721e499ce80"
    sha256 cellar: :any,                 arm64_ventura:  "3b4e15c2875d054f8b98c0a78e5b35f45301a84d2121bbce489eea59d709eaff"
    sha256 cellar: :any,                 arm64_monterey: "a1246d6b71aba4bb9cf30455cd0dd13d8e9d4cd42bb400703d34d4d70bff626c"
    sha256 cellar: :any,                 ventura:        "d61278e2d8091f21900a39a07a9054a044357f35ff6c896b6680f5c6799568db"
    sha256 cellar: :any,                 monterey:       "185a3ff35368b3d5b39a8bbbdb82b531b6c06cb3088104a1afd4d8fc8cb79570"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c307cb597cbf92daea190ab3ad661997b45fab742326379fa38ad6920d48b24e"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
