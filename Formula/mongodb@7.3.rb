# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a09ac30e8d9dca6a5c5374b01750c2723aac72269ae527e117d0062860056689"
    sha256 cellar: :any,                 arm64_big_sur:  "886c39f85182ecba6c9a9157842b9b072c2bec0b1e6724a98a10e8b832dd28f8"
    sha256 cellar: :any,                 ventura:        "ce3ad60bd6f673edff048da8f533ae7658367d1ae07cc055ccc6f9aea08cb639"
    sha256 cellar: :any,                 monterey:       "e1c1ab99303c17b9add9dd889f1c2d6790d249d2bdf381af473c85aea1c73e23"
    sha256 cellar: :any,                 big_sur:        "0444666ee7b02c3e31e195978a02097c3888de82a9d3087c7125c39712e823b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b6f5e9d5ff7143c8d29bf3450c955f50fcadfc7dfb2c0da5702edc78bd79cca"
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
