# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6172c60f6e2cb81791c029783d8badace29b058b322b864edd1a18abbf328ebc"
    sha256 cellar: :any,                 arm64_big_sur:  "dc26387edc3ecddf3717c03f371d8bd9d080dbd9aac49427292ab1995827b8da"
    sha256 cellar: :any,                 ventura:        "ab282429cd44d4ebd70a92c1aed79b6780633f0b28925a6c7515fe998a009d62"
    sha256 cellar: :any,                 monterey:       "99a2c17024ac173516cbd748788223f6b08141e16f3a64e29cc4442d247c9b1d"
    sha256 cellar: :any,                 big_sur:        "aab1a43dbd3b6171776aaad79d809930faba1886887f92ce8e2118961160ab42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "30b19622004813822a09669d56dbcbb8def31397350fcecadc09e07e5ff5f14b"
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
