# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4f616dfa809e4c520c09c3d57ebdead97430e2b3a342107fc0aecf3f39889e2c"
    sha256 cellar: :any,                 arm64_ventura:  "44d51335273f76c7cff91bc410c1d26adaff3c0ed952adaf9e69cd783ba99e6a"
    sha256 cellar: :any,                 arm64_monterey: "77b94ffd2e1586bd5b4f78b6d698613f915a5afc25902e219ea3561d938d51f9"
    sha256 cellar: :any,                 ventura:        "ad4075a90b528766d047e9af57efccbbd5742c56305b9651e7d31128598cfe97"
    sha256 cellar: :any,                 monterey:       "2b6bff4fb118284726e25a23f49a1346803a19f01d73cd7d1353afe087c8e947"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "856ff82bb9bf07ddb561ab4bd32e45570c7ff15ebea6d2bbb5a7c606d51e9ff2"
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
