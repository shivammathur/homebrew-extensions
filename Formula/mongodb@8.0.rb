# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.1.tgz"
  sha256 "34b7d0528b5c3f2b9b7f677294ad7aa7822bb704ba6583bae99f2bbf79a29be1"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a4ecc433afa0423be632df19bb9ead28063e4f932816c9f74382b00e3d1034d4"
    sha256 cellar: :any,                 arm64_ventura:  "e94fd76291f4a3d454244bd729bd971385334de7e93482be198871a55897d8e6"
    sha256 cellar: :any,                 arm64_monterey: "ceaa45ea94b5ea26d8f777b50a6b604f1e09a0fddea9dc7f1626d33c1ab5da2a"
    sha256 cellar: :any,                 ventura:        "0a118c2bf116aef68cfacbc02326076e1bfe50d7417cd73a44d9d49f06a763c6"
    sha256 cellar: :any,                 monterey:       "41318a94240857216978f380ff1596e0a6692d56343f16066d24f83c0bafebe7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1d8606a02aaedb659380ab1b69e2458df48775fc2e550e648fdbaef56168ec4"
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
