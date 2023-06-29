# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "fdb29755214cb1cb3936448ec43f22026e293b4d49978d6564f8e434c92a8d54"
    sha256 cellar: :any,                 arm64_big_sur:  "ecb223c02ee3f013ed32b24e83c8bb2632ddf7f9bbb8dc1d438a4d0afaa0c01e"
    sha256 cellar: :any,                 ventura:        "a327b2612ff6c018a19db909a32c07c873f9d917a16ef4e235c94d8038337a90"
    sha256 cellar: :any,                 monterey:       "3dd0d04fe8d05ed313c9cac3bfd9f529d99e9f33d6a8dbdc0e5d0877cefeb5a2"
    sha256 cellar: :any,                 big_sur:        "8b245926a1996c0c6ea9b78f8c0bf3c7e44dcdceb4a0b7a593210f06ed761ccd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b3fc7a2b6b32311c721f98092cc2025816b11cb06057d5e10c66d667fabbc67b"
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
