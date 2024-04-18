# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d261e63b66c1b0ed0c9b4e53eb5692ec631f93a6545f408a9d09a547a5441029"
    sha256 cellar: :any,                 arm64_ventura:  "4513e2fd3b6d71ae7e106217a6689cb3d06a1f44ec7d856ce710d044d963ae7d"
    sha256 cellar: :any,                 arm64_monterey: "ad6992aa6627d751856c76976f15fd18f42f21f13ad6ed1d83f09fdced75a219"
    sha256 cellar: :any,                 ventura:        "8e6dc70788be47adfcc58f5dbc112b331fb6f0b60d144eabf26d3dc6796ec3be"
    sha256 cellar: :any,                 monterey:       "0e9350a7aef4f977c0b4d09c9fcd2da4a150ae8489e7363fcf86a10175ee3fc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9097ec71646faafa75267bb10a1616a3b849cb612a94bf580bdf1f3adbab3c4"
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
