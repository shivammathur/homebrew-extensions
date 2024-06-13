# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.2.tgz"
  sha256 "04a82c33710d36bda551522f33067d334dd20945f4db680cca5485d10e8aa5c7"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "5aeaaa693c2a0495e5768479016c424e91e3763ff54e826240c7cfdda4f2dc0c"
    sha256 cellar: :any,                 arm64_ventura:  "d69978f3e1f76635a91d0985b9920127bd006476207829994ef07a9e2586e900"
    sha256 cellar: :any,                 arm64_monterey: "22aaec63277a554d746aaa1a52a1cc9d8562e2c4fa88e13f18e326c600ad6e22"
    sha256 cellar: :any,                 ventura:        "4eb15ba2ce16afd2a4428171abbd9d7c2fff7888e54197d4854145b299cea0c9"
    sha256 cellar: :any,                 monterey:       "5c1146af2272b77a77a08a08daa5032faf2e4d07d6876c6e88c90f376ebdac26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f5482c20eee724a5956b205fa62ec2f8342a13d6aca1c880401f525a795bfd05"
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
