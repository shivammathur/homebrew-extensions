# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "44eab61c71b1e4b913ba6daa786ec509cbed3585f18b766a4ca2b07e3af4a085"
    sha256 cellar: :any,                 arm64_big_sur:  "b444ac98fffcb41e4ea16766ae58eae959a6d5eefe4339f61b64e431f997dba2"
    sha256 cellar: :any,                 monterey:       "b7b9ad0417d86b78d1d267a3ac4e5faf806def87b5af7faeb54186997142caf8"
    sha256 cellar: :any,                 big_sur:        "a0ef14bb64233b106f46e290de7e4751770c53e3a114fdfd4c8f37e0453725d8"
    sha256 cellar: :any,                 catalina:       "9fc62d5fc4d031a84e079d5c2bd584943e3d0c596ef367062bd34db3997c9041"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "000314bb2c18c4a4fbb664c28a85070df9c494d65d8572f01c3a929602b64974"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
