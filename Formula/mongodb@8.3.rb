# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "70c31790b3a704ef03e5b2f3aca61c412333c9fe7a3bb79f8bf770ffd643053a"
    sha256 cellar: :any,                 arm64_big_sur:  "cbc779c51f26baa38b09ceac0b4a61ac988226824cda4fb3768bcb33af85a156"
    sha256 cellar: :any,                 ventura:        "dd587b268d0f8555d59cc4d2797fb844144c3573f0c6686f920913c2a502a121"
    sha256 cellar: :any,                 monterey:       "dea0700db89a1f9a1cbde102729facdcffe7b861cb93c6371641f0372699a1f8"
    sha256 cellar: :any,                 big_sur:        "07069930c1798fa81937f6e322c4a98b4fa72716e639546296bcb8e788bab733"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6114b1008745117581476fc9590e3ff22165eb5bd95c8465e9bbce616607de4"
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
