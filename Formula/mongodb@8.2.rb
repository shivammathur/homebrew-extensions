# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "47d761eda44c8a3c7beb976f05b904364b2a4bb0f1af95248df914151f456d13"
    sha256 cellar: :any,                 arm64_big_sur:  "d37f7a152b6e843a4b347c2ecc009ecec74c92cf8d44aa7d61a22f7c37ab01c1"
    sha256 cellar: :any,                 ventura:        "c8e5329ae257c3209fa701ee6a324f907c0c2a084d55c2447ecf0ede613c94f5"
    sha256 cellar: :any,                 monterey:       "2fc1740b04095145d32a8376984afd98a1d26ea412141c57b3b6aca76c3d6a63"
    sha256 cellar: :any,                 big_sur:        "8eeede9f10f5d9a73eaf57bef8b3c3de9a6f35c9dff1403a390a77c6304ba849"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb10a63c1adc93639f1aeeb678ca1c093d08eec3a06334a96f6fb936f9bc2f04"
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
