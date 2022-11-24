# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4fcaffdcb52b7e5a3534e261371280b8d17edad7a9529d92dde47063d8f49ae1"
    sha256 cellar: :any,                 arm64_big_sur:  "64027aabce77afa0d940e56d42ac4afd6de86effe6cdbd46f39d365c1be3ac02"
    sha256 cellar: :any,                 monterey:       "fd441ffb3564dae324f5a2a10398c06154b8740280826f98c6d4d6fb5d390b8c"
    sha256 cellar: :any,                 big_sur:        "3fb4a77aa1d04e5d71f892aa62efdb6f03b756ea8962fb27efae0841f1b4c55c"
    sha256 cellar: :any,                 catalina:       "3f6a0d916756ee5105148b3bbf7b8077e094b222fb40287aa645f64cc51e2302"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f117de851686dc014febf25fdf00b25a6fd27eb682856422839dd257df7db29a"
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
