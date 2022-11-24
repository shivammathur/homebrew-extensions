# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2be1279f6d8b5e48336b9229266f1bda51a9090f35b50c1219eb50d96e63637a"
    sha256 cellar: :any,                 arm64_big_sur:  "657ca0747ab98f970d275396cd0d6a69e534b06b156cbbb31f268168793bb20c"
    sha256 cellar: :any,                 monterey:       "c8710fce87f3e7d553c94d2e5c49d74e8ea008607e88bf1e90a8cfcdfa36b068"
    sha256 cellar: :any,                 big_sur:        "563d5e29c8d976e390955d01b1d0b03a3ae0078c83f49265ae6cdb93e2bcdbe1"
    sha256 cellar: :any,                 catalina:       "4842e03bbfa7e1a4befa3fa2489e7ea1e40e0b05369278a444898067dd025913"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b02765c3aa2acfdc272d50deaa94e9525fc02bb9e8e5df89ad4d40acc981757"
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
