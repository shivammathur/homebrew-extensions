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
    sha256 cellar: :any,                 arm64_monterey: "f4bb1aeeb34b387a568ad012ef02c1799697bb359654bce9abac7c538e329927"
    sha256 cellar: :any,                 arm64_big_sur:  "8d21e1a62ceeba538a5b41bfb210ed0af35737fe685da121c77f8242bc93bf5d"
    sha256 cellar: :any,                 ventura:        "e4d3ee900000db3dc45b8e18fe435f290474d32c0d04d7fd56e8473682c6df2b"
    sha256 cellar: :any,                 monterey:       "7949c1dbfe49f146e401caaacf41d5e897ad9a61ede6645994ac20f6ebe75fc9"
    sha256 cellar: :any,                 big_sur:        "c4442e6bf842ffef5132052c90aa8f7309884125678f966e76ce99d637b45586"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "866ebb92ce7d0a861136a1e3dcc7dfe9bf2821689a01a5c67602cbf960e9d218"
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
