# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.1.tgz"
  sha256 "0ca4e21db366cec712cd7077af8ba4fbc8dfcd030997c052a30274c0e5468e9a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "55fb8ef540afd5f9a168479196e2c0d21fee3a8fc9c27b3aba6846a1bf9b7ca7"
    sha256 cellar: :any,                 arm64_ventura:  "b11a45fed29a0e84fa8cab60ccee0911b1dec016664b4ec3557d3ec4c7ab4316"
    sha256 cellar: :any,                 arm64_monterey: "390766c2633957e5d9c829580b5ea5fedeca1c708af65c1e5de60d4719816e9f"
    sha256 cellar: :any,                 ventura:        "db9313b60a6a3fb4126e316d2f9c47c67a47164f4ed801884a30f45b43c4ea41"
    sha256 cellar: :any,                 monterey:       "040191391e02bc4f6827063a73b61bf35e3eb492d536a9e424e0ef5e1099e2c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a3039166d71bb264b1c92016ea1917f0692e1df4dc474522187095cc38eeec5"
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
