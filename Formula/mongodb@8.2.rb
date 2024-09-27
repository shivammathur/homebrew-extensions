# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a856d320e2992e1f5d28ae19ba9f42a7dda7ef83dbb54d451a04a5b46df93b4a"
    sha256 cellar: :any,                 arm64_sonoma:  "6e8fca345399423390232a4fd265266009e55eadde6273853fd96ab0d22781e4"
    sha256 cellar: :any,                 arm64_ventura: "1ece7173a2c2492fbc5b7091213f3721ed0fcd1944004e377aaffd3acfcd2ec6"
    sha256 cellar: :any,                 ventura:       "1afce1e1f9ec145508f1b647db132b71647f5f94adb3ba1d213a4d92d0ffbc86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2195900c24de347b108b02225ec52934d230d4f70d35d05e099d84af3e8a9a0"
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
