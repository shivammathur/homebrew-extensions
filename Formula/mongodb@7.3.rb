# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "76d3b3601fd3123de072db4b966f773eb4043b4592a505a6173c8da000112f28"
    sha256 cellar: :any,                 arm64_sonoma:  "a1c2e37715263891030e6435ea2399e5773e0e9120c66f578034d22b06ff6544"
    sha256 cellar: :any,                 arm64_ventura: "99be18eaed20e2343e2c58ca26a97791eecc94cbde30b0afc994112242abd890"
    sha256 cellar: :any,                 ventura:       "47b1039e4e2163b3fefb067e9a5d881cc4ee3bcf2debdfb9a5d53348799b28b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0fe10e9513345c93840b26e40f0d08fd526f3546cf79faa4f5d11f9ae91e3b9c"
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
