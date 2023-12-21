# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3724f9276ab150fe3b55074be7f13886e25948db188b05dd9c80b5f8c362a940"
    sha256 cellar: :any,                 arm64_ventura:  "74048052379e2198a8a0ca02c47e42a9f8df09889b87e46ee55a99e38ea14268"
    sha256 cellar: :any,                 arm64_monterey: "26545f53ff0a12b33281183205bd70c7a483a38e2c544923b24a3788708e33ba"
    sha256 cellar: :any,                 ventura:        "9dd955c7fdf7bcbc55527c324be84b470ea694c740da7261ebe438d48e9f89e8"
    sha256 cellar: :any,                 monterey:       "5f251870b64733bd306c73ef9039ea1992911a934e2572e5c25a1afe6f8d0a82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec7a54bd7492facdc1871be62074909dd6aba2cfa2573d5b979b5537804be0ba"
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
