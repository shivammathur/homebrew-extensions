# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "711dcf471afdfeadc6d083ba8e5391244c57968b6db1fe6d8e3f7001cb98c98e"
    sha256 cellar: :any,                 arm64_sonoma:   "9d0e6c46d0bc15d0aacceb5950f31542e71ac23aff0c8c966b2c5934aabc45db"
    sha256 cellar: :any,                 arm64_ventura:  "d15ecc9cfdc4663bfbb2e3288326c017242371ce0688c2d0c2cd6e8cc28dc9b0"
    sha256 cellar: :any,                 arm64_monterey: "c5cd74fb95d670804f3c4f73b4641b2aec77a3ecd7ed7b500339dd1f12741d1b"
    sha256 cellar: :any,                 ventura:        "5382905c6d734f266e7013cf18a85cacbc5a6589882fe1944f377d8e990db00d"
    sha256 cellar: :any,                 monterey:       "d55f6c0a3ea84b2e1d5a335de02c320ac77e19acbb417c4e9a8732b85641a9a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a7ddde599f73cc5c5523f1cb1f08175a52ef7f1f44aaf1344ab31903fea586f1"
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
