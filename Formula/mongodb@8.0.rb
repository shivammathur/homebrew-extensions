# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.3.tgz"
  sha256 "e1ea11cd3d995ef9f799245aac0762955792308efbc9e93260c3a587643a9079"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c24530561c0ce2d2132296bbda20c1cb03730430420f9e3b398a6703bb82c345"
    sha256 cellar: :any,                 arm64_ventura:  "de3caf8f81818ece230a66a90b4ac908b801f934e78c978eb47fc7592b5e890a"
    sha256 cellar: :any,                 arm64_monterey: "70bc1ce6dcb9e694099a23616647ff4463d4b8858d868ff4fcab0167b77c0f82"
    sha256 cellar: :any,                 ventura:        "20908284647e17513392d07a51c274c1255bcd1fe666bd8da61e8a04946d935e"
    sha256 cellar: :any,                 monterey:       "773832cbd31c3950a1fe5254ff12f8315cbe2dc399d1bd1f2df57951c0c2e40f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69a589b7f533303b24c8a85e68897914547c06d15632905f6ab6586cd40b5eee"
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
