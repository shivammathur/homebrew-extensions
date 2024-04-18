# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ef64ac164a0da20af3bf8e2bf04cd5b804b3bff9552ec391b9022dae287784c9"
    sha256 cellar: :any,                 arm64_ventura:  "bc193e1ab9d915191165c981fe8ba47f8fdfb12cb57a0f4c4d80e1c4e2b01655"
    sha256 cellar: :any,                 arm64_monterey: "94c0cf4fa8c61bed31d1ff8e2bf26030095a632dfe146f59b3ab5e178668a5c1"
    sha256 cellar: :any,                 ventura:        "6d878f5874ea90d3a9f1c0411badb39af2f361102d72b5f5f9f0553e7b550db5"
    sha256 cellar: :any,                 monterey:       "ac8d6972c61863b73dda652939fe229c6cccde46e2325363ef904de0173e2dc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "260f8ec678c1d670ec10abab489101bf77c0e8795b1d9c26636b692dd4ea9e11"
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
