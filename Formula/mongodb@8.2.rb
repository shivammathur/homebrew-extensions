# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver.git",
      branch:   "master",
      revision: "c0dbf158c99c84cfd487f0bf58f2a25cdc0e872a"
  version "1.10.0"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "5aa54346bd5d22c7bd0f1f3e37022d3835d1f53db14c47f0f29c50781111a90b"
    sha256 cellar: :any,                 big_sur:       "3978c4e0445a783b98ee7470de99dc473f67af07d4a18a068af1f3dce188c0ef"
    sha256 cellar: :any,                 catalina:      "e98f7803b96345e7a869704d21f37c31ae03af381fbc6546e061df81b372990e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d04aaedc978679598c9dd192a0942102ba00178db9c28028824d6fea2c3f9025"
  end

  depends_on "icu4c"
  depends_on "snappy"
  depends_on "zstd"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
