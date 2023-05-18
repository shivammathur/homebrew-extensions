# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.3.tgz"
  sha256 "4f2c4e417fb606b462e870ec03656f3a97ba0b399dc24a6d9d153e9846134388"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8cdad4938773e2ffce65f384f8d04bf3ec1d3e3608e4e24214ab9355ce8c952c"
    sha256 cellar: :any,                 arm64_big_sur:  "5bd1e3d14166fa258c2f83341b4036aa2f2f2a6c66fadc358bfa436365317ec1"
    sha256 cellar: :any,                 ventura:        "e0576ac80e44381198405f94009bdf7010f0d1994ce1852f51373a72d1fbb84f"
    sha256 cellar: :any,                 monterey:       "d25636e6364f645dadc1ff7a8310a29d4b53a2eea3b636fab1d33c4f913d4c7b"
    sha256 cellar: :any,                 big_sur:        "e1e883fcd47d464c54561e3354adce11c35bab8ff33c217d72f8bc20bdc77e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c733709746690c2da0ddb3cc404d29cf982f7d260c1b8c7c322a12a7fd96c52"
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
