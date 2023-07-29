# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "12a1b61e3f2b7ecec490f7d2e9a561f929e4d9e5bc85fb5dddcb31fd7d65a6af"
    sha256 cellar: :any,                 arm64_big_sur:  "80af1db0c4888d5254286d36079e7c71e4b541ac22c9e40fbdbeaa103c36f7e0"
    sha256 cellar: :any,                 ventura:        "725de16eddb41b6e101a8b642a6823c6054dd193556c3e2527aa897451064a5e"
    sha256 cellar: :any,                 monterey:       "9f8aac1d9c3daf3c0a0397060ee6a558dbd1d2446b9baa0ec9039463fa72049f"
    sha256 cellar: :any,                 big_sur:        "075ca43031e7df83840af663af28a1af4e455f54cfbed9f989fcd6e82a73ddbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e9bdf3ab2c9421cd08dc88a897c116ce8e12faf021a9e1bde96ea32aadfcca24"
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
