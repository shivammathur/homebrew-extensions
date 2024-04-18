# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.1.tgz"
  sha256 "f957b71154052fa9706ce703f4f8043cfe2655367455483798b59269ebe9f135"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "81c541ae6fdd7bd1e3f84a7570bc90cae10ac27df900d1868a88de5cc812a9cc"
    sha256 cellar: :any,                 arm64_ventura:  "7f822e0acfab7a7921b45c5bd2df62ac94f8849fe3652fa172aab2e98d603de2"
    sha256 cellar: :any,                 arm64_monterey: "abbdee10dc2c9b3b3778a004d6c8ae28c81ac1d8a83f71c7a2bf37e6d5111549"
    sha256 cellar: :any,                 ventura:        "0245f6f66bcf238abee5c16f3f1dcdfd78b16f2404524b738aab069a16e206ba"
    sha256 cellar: :any,                 monterey:       "9c3c00f35b4a0de86c1c5fb491465e4a046d115c52f8f221b9b0d98f820e911b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bb5364b978fff2cd2fa4d1c249b340769ee0c1915c876f670bbcb25e4a9c310"
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
