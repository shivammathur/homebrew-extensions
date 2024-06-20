# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.3.tgz"
  sha256 "a9e17b024971b78c896413b46722444e5c0d004e3de271490c9d3d55e34268e9"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "32e50ca88c1fa447c87d2353ba77a61f0f5d4d3045acaf46adee8bd0a0ea8d29"
    sha256 cellar: :any,                 arm64_ventura:  "dee0ec2ac530e6ea17a78b4846fcbf45c8b2c62aa50121a312478d8e6f42167e"
    sha256 cellar: :any,                 arm64_monterey: "59e2177fb18ad5d0f61eabb0d29c48da700b24f26fac0fd3e97851e2ed56167d"
    sha256 cellar: :any,                 ventura:        "b71db45fe9d14dfd5211880971586203c26cb3a84cb5488609f74bd9c0c81e47"
    sha256 cellar: :any,                 monterey:       "d76960664f3c18528e7816cbdce3e27242f8f744565e2ee3aef6b6f2f00859a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74f46cdacb01d9ba154ffe42f407ffe0d1f7671e37e4a6e83f5c27e7eaaf3a21"
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
