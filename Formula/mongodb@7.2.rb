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
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4d1e196793f3d2ffc06490b35e085a1a501d24c0ad1342c90c8eb597a9a2cc0e"
    sha256 cellar: :any,                 arm64_big_sur:  "78f7438f4250dc694f717ce558304dc637fa31a7e1173be53aa422d8eb59fbde"
    sha256 cellar: :any,                 ventura:        "d2664549d1103b4560cbcd91e013a54bda1c9a60508b943cefb5168849c30c5a"
    sha256 cellar: :any,                 monterey:       "ff67f8064c09c68cfaad4ac929fd1138817b60c5d8c83affc1ee7e17b90d4a9a"
    sha256 cellar: :any,                 big_sur:        "e4fbbdd717342a8b23aebd7686334d4d191921f751c735aba1de9557af30bd3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97e74c2b2dabeae942a2466306f674f52cfae4403c328742695968a283325397"
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
