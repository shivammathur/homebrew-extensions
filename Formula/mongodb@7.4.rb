# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.3.tgz"
  sha256 "a9e17b024971b78c896413b46722444e5c0d004e3de271490c9d3d55e34268e9"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "148736349b0936d3f0ae8ae13d1721bbe0cb0c584a5419a9e82f178d4bcb8db5"
    sha256 cellar: :any,                 arm64_ventura:  "987f7e0c30ce5d96730a60abe155fcaab733acadfd860fa40f3c3578e675f53c"
    sha256 cellar: :any,                 arm64_monterey: "4891ea9ca3d2323ca088ec2c55c30be6bc96c7d63e468ba3caf48c2c5a043097"
    sha256 cellar: :any,                 ventura:        "8c5ec53ef58a137695f93bdbeea892609176b283e31fbfc7a7be576964955d95"
    sha256 cellar: :any,                 monterey:       "dc2e58a05507ed8b525f8fa768b48d5a340a1c6fceff8a8e226a751f42738975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a82b28bee05b3c33a8eb6144476bfda47d30f205ad0d975db569832c8c75f115"
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
