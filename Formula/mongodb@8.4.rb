# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ee9f51d8e36392760d0c732b6b94f77a65769fdb0d64d279fef388464e6c5c12"
    sha256 cellar: :any,                 arm64_big_sur:  "c4c1906bfed3837dff40d9b69ecb1628a92febdc1ff1d0ac0ed5197043817758"
    sha256 cellar: :any,                 ventura:        "6a115282197eaf196eed7f94624ab8a0928f44d8255cf02c5fb9e66de2ba4845"
    sha256 cellar: :any,                 monterey:       "2a66ed34b517c4ef01d1978cb2d5dd860192f0b059e1a0f76ad7ed3775a2db11"
    sha256 cellar: :any,                 big_sur:        "6c48041dd30665229e0374505b04bbd41989b39158bc0f491f77edea345783f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca4c166cea2003d264d61bad29f5d381ea65340f4aab4c38c9c5dcc9f816ade7"
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
