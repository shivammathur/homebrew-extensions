# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.0.tgz"
  sha256 "5e7db95103d73212ed0edf8887d92184baa5643476045cb899efbcf439847148"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c6281be97145065e1ed01949d2f8d080a75c4e9e837c69156dee8d8062dbc3b9"
    sha256 cellar: :any,                 arm64_ventura:  "bdf4b9d431a0b045582761fa7b62cdfe33d1f187af7a769eb7315014b9bde310"
    sha256 cellar: :any,                 arm64_monterey: "5b21eeb65a6babffc36e5411d5059eb77e2d57a0aa07c2f6589c2c2c3bac4b67"
    sha256 cellar: :any,                 ventura:        "fa1856afec0e5268a700fef48a12af77eb649cda2adb597444c572d72e1b11a1"
    sha256 cellar: :any,                 monterey:       "fbd8248bc49fca9f4ccd55a3e0cf3022539d3699028a86428457c5de8b48880a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "78483b52fd875d2806af3479e9cd11002008191b4c0d18325292a1cbb3c84269"
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
