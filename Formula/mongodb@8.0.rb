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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "863aab33c5d300bda3b5675cbafcde82834ed95b7b5f918541dc7e0b6c2f8b0f"
    sha256 cellar: :any,                 arm64_big_sur:  "daad3b5c2d6620e73828c72ace7a4be5b627c964ef44f88d39abd9e5a18a8682"
    sha256 cellar: :any,                 monterey:       "a090cbf51b28bb507ed0699e356c21211b38a75d8aaaba08640874b330a88f43"
    sha256 cellar: :any,                 big_sur:        "51bd9fda0bb67d171893eb0af1845f84343f09fab396fce9d53928dfb72274bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a7f2cee97cb707b73eacdd70ad07b5697007cad5d6e9e942cfb4ddca1cb7760e"
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
