# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.2.tgz"
  sha256 "d05fb9ac9846d1ea1cf54e918d2f94f07682ea1e5d181c1a4a756313e0cefa2a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2283e389432b5b57493686cd48e2c800e2e5738ca3cf6a0be133128e3f1faa63"
    sha256 cellar: :any,                 arm64_big_sur:  "befe3e07ce83fc2f15b6d081f932a03236357db44dfd9becfd69b718a490283c"
    sha256 cellar: :any,                 ventura:        "7446ad2199746013fb01126ccf06b273fa915089df361366df1ed9ebc215fe1f"
    sha256 cellar: :any,                 monterey:       "304063a8c209f08dc72da572450cfc5d0e16e9170acaaf24425ea7c7bc0e7430"
    sha256 cellar: :any,                 big_sur:        "c980c6e62c322732b55b8eb16e6201e3b5468ad23bb1028c6a2a7ab4fb3978fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6441b9668a37ddcc33f4e844cd0dd601f9b456196279797e90ba27750102996c"
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
