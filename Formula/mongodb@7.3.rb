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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "75c3548c8e2f59eab35c31052a8bb9d60afc2333a47d881ec0b6b3cc1fdcdf91"
    sha256 cellar: :any,                 arm64_big_sur:  "66d190bcba49469d510ae968c3a9153c2f4cf29949d0c3bfaffb51f2553c9f39"
    sha256 cellar: :any,                 ventura:        "7e18bdcbc55b22696b798ce6fba51ba107e1a9cab95ea25f6b4f334c27b3ebc2"
    sha256 cellar: :any,                 monterey:       "ac58f4efda11ba235fa02edc51515708d2e0edcab362b9977cb12ddb5299ea26"
    sha256 cellar: :any,                 big_sur:        "e6c627cb21298c6a94e32ca27f52386420871754593f17a289143a8ae6b65621"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "76d8ff6e23fb410a33e16a6fe726cdbd9c087acdebc2865a13f493a62abc68fa"
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
