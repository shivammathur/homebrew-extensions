# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b1fce6988b5e7a13b37a95397b22a6209d7596f54bcb9a840cf55028b75c2dd9"
    sha256 cellar: :any,                 big_sur:       "c0192320281cc4f8ace65e120baa88a317def6904dbabaa2ae2f26bd7dfff22c"
    sha256 cellar: :any,                 catalina:      "8593d10169c8f0ccbc4825365676196826225a910b1d243a63dc4e37cb8fa41e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b50c00231440400e75b3987fb1b6765e8ee247349d854abe193f8f0b013d1954"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
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
