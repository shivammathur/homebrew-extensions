# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "30f736b0f5b6149ace128ecb87469a0dd9e04c681584fa138ce435bcffcc55de"
    sha256 cellar: :any,                 arm64_ventura:  "f903d925061cfbbe48b97424dcd827f51fc2ad9d4fb63e02e194d784b834c21e"
    sha256 cellar: :any,                 arm64_monterey: "1bbb98a9019f8fc9878175ff2aa2584988109346963be6d0b7bc7eee2ad8dc1d"
    sha256 cellar: :any,                 ventura:        "5b44877680e3c07c1d6b3a29f6d87b39ae23106511ecfee8177219747cad564f"
    sha256 cellar: :any,                 monterey:       "dd09848cc002802f2f27b44ff2baebd2ccbf513d907ce84f5031ed9cfe15eeeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9dfe5af2eebd75f1fafaa67ceca8aae58c6a46bf903d41159241cb0e24e71ba3"
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
