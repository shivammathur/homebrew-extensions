# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7efc688088dd1997d39ba219fb5ee6694df82131889373dacdf7e3b4d88fb71c"
    sha256 cellar: :any,                 arm64_big_sur:  "b23364cdf86ebc7b6804aa3db1eaa9f506b703a7bfea8426696c87913a14c5d0"
    sha256 cellar: :any,                 monterey:       "bb3acaef9d391e2c3a751a501ae0fba56c5e60aef9078175fa4f5ba75c294bff"
    sha256 cellar: :any,                 big_sur:        "bd282b537c751d0d40d81ca6459c4fe91c9ec95889db847812c875be93cb154d"
    sha256 cellar: :any,                 catalina:       "ff98ea4fac39a2b1713d878a9525168be065766ec26cdd01e3e4c700823a66ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc66459ab28f7ac08c986f78092f4e51ca33fd48c85eb5da45c41e132667fd73"
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
