# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8453c817e577e925be1db1d003dd451ec0d5c829d1db95e22f65e70db97e7d0c"
    sha256 cellar: :any,                 arm64_ventura:  "01f254c45a9343e0b61d5f40201d0df3c58c2ac4c0841a001ce09a53e132ca71"
    sha256 cellar: :any,                 arm64_monterey: "7acdc626819bc2ad598fc10fc4b389d098f1dd0f4e3d32b8f2f8007db2d4753c"
    sha256 cellar: :any,                 ventura:        "9f6a45014d44ae5f61c3285c439c08c269f080164bf5466f9677a4ba1d26d751"
    sha256 cellar: :any,                 monterey:       "967d76cd3169467e7a331d8db25739ea8c7f0e610461745e4cd19268436f5f0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37cb806c23acf4fd9e3bc294e716e512a90db07cad4c7f730ed15999844fd1f9"
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
