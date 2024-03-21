# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "126ff959b461a603e36afc50f9880ce128a6572d908ef1b41d6cae4776870ece"
    sha256 cellar: :any,                 arm64_ventura:  "e8303d5d74d379cb331f41e402c803a5a23aaa49a3ef6ccb0d59b4a2672be02f"
    sha256 cellar: :any,                 arm64_monterey: "57d50ea75f966eda33bf3c49cbd26a0bbff0b43a96413d5af7650a8f92360a34"
    sha256 cellar: :any,                 ventura:        "d179c8da588bd64b44756f42fec122affc9414484d83ee5ca3aa84f2bce9d660"
    sha256 cellar: :any,                 monterey:       "58d2396520ae8b85389d4e5eeb0baf7363fa311410714ed51344e8dea96dfe91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49eeeb0534cb424a30aa1d8f348855ea690614c39a0ce251aeeca5bc030dc451"
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
