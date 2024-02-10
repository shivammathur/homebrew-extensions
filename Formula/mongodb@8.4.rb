# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "a600d0bdc1cc4975a06c973f0aed1b1c06ed39ded7b457be1c8d16e5a58b4dc6"
    sha256 cellar: :any,                 arm64_ventura:  "b651608e40c9a9bb30e7eb4a9edabe1eca0cdc89fd342342024556fd0d8abfa0"
    sha256 cellar: :any,                 arm64_monterey: "00b3b1bb2dc8f1eb442be978448f3fb7e1e267209f2275b01dcd8ad84faff6f7"
    sha256 cellar: :any,                 ventura:        "a20bdd655508d514ba437ce1eff51665e46b912afc1db2d782f99b0a309a3b3d"
    sha256 cellar: :any,                 monterey:       "0b41e5fb1c0ee16737ab70c981b2dffc011c5562ef30a473594b3e89eaaa18b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7bba60298086550e1a675ef80d2e299a809973012ceec35fcf15dd653c3fa3f1"
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
