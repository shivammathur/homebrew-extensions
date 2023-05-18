# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1985cb4817807334fa89a5cdce901457d42907bbae24aed76750d014d4877459"
    sha256 cellar: :any,                 arm64_big_sur:  "41bb2644d93292242735796f36ecfacf7ec0817cf0df9ba625bb7d91afa60ba4"
    sha256 cellar: :any,                 ventura:        "d841eac31c5b0270ca3150da19418c10e8aff542969c2fb315b89c20b66f27c2"
    sha256 cellar: :any,                 monterey:       "b2778405e568899d4e616d4a8d8d4f78735b61738b486cf500dfbd00bace2595"
    sha256 cellar: :any,                 big_sur:        "a7a870b01de3c851fe518bf2a2e5945531fb776946c4dff0289afd9f753104dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8206af9cdb5d973121cf1a2f1ea73e86427492d94cac2a49c62cebd87fc5b53a"
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
