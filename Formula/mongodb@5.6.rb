# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "9dc897d4a39bf0ab9465d3e1b61023c4ea1afe3384bd8fc6aa46602eba27986e"
    sha256                               big_sur:       "3344d15888290cd730aa2d134d83e8b974ab3cc63f2b289867315fda59298c12"
    sha256                               catalina:      "64e48fdbbe5027a4dc8474734ec608899c4dc3147513749680f10f4061f78952"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86e3fc1d87195afb34f44ff46e01be5ca88d61247221d50746dfc6d82bb0fa85"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"

  uses_from_macos "zlib"

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
