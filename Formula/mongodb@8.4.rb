# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "6f79c43221df3e0e9a0db21488481c1e449405066c4759ff23ee8476fdd8c953"
    sha256 cellar: :any,                 arm64_ventura:  "de87dfebfdafc58755f1e35e8f350167cf64f6c9e7a949a83c251c8146657dea"
    sha256 cellar: :any,                 arm64_monterey: "469dbe6ab009a610b5c33571fe3784f2d3ee290fdf807bbf50df43d37b6ea587"
    sha256 cellar: :any,                 ventura:        "2d8824f7996d1e00c24d90a738c02d5900c3478fabcaad7f5c083eff535edd15"
    sha256 cellar: :any,                 monterey:       "19757686ada38184d6a80d0c7e9d58cf307b62f4b6b5376e4e538f9b3d8f2c6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "543841b0e16f168629331d27ffc111b7e30a338dd522b1b7f42ace36429dc44f"
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
