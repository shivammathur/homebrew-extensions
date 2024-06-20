# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.19.3.tgz"
  sha256 "a9e17b024971b78c896413b46722444e5c0d004e3de271490c9d3d55e34268e9"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "24127570fedec672ba08185bc8745d99cd001b27630c6311610231cf2068f645"
    sha256 cellar: :any,                 arm64_ventura:  "06204e8e5895ce0448782475de1b7b4eb0137896b93e6c7f6431a6c82ada2cf2"
    sha256 cellar: :any,                 arm64_monterey: "c79134dc7e3550293fe2c29e5743e860a2e0af86ebacf8eaa1d3ce5b1312afce"
    sha256 cellar: :any,                 ventura:        "ea4019ab998118b39d3cbbe704a5d9c77bb0b040875382451668a28cb57a31ad"
    sha256 cellar: :any,                 monterey:       "7a005c409ae4af535bdbaef60c98a4a2c94daabb448f9333ca3fde25e91a4349"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aeafab5c2d31a9d078c0cad4e84d80d66531284019b5ce393da2476ceb531ad6"
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
