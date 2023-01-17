# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/mongodb@8.3-1.15.0"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8b0630fcecfc08780382a319524166690009c7f46b466efac0b54947697ead03"
    sha256 cellar: :any,                 arm64_big_sur:  "744a393f4424717c9bce35cb93a410598955af4a85e44b1b0936b77a210fbd85"
    sha256 cellar: :any,                 monterey:       "7e68b532700fba7101435b5a46fd349d0c3d080c3e36397a03b1af24cdfcd57f"
    sha256 cellar: :any,                 big_sur:        "64781683fa7cf071a0873ea64bc44089aae5bba37e9b75ea14eca4c7ab64091b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c7c67c99c8e8f9830c8f6a78e74d7040415a17228562ebf5a9754f5f41db52cb"
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
