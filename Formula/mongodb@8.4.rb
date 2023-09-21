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
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "681474dc3aca53f83067f7f96a8615cc907205c7adaed1a10f4f1540cc0f67cd"
    sha256 cellar: :any,                 arm64_monterey: "b5772814b06c0d6f3a7887a2dbb362f5edf478b2829781029dd28b8ca65d86c6"
    sha256 cellar: :any,                 arm64_big_sur:  "946e99ac22f6d30f07861ce0d12fffdf2bce4dc4e9c1f6d04fb33428d96ae60c"
    sha256 cellar: :any,                 ventura:        "1f723bc9fdd1f98446bf10d2b209415094b5537d7898cfc2cd32aecec7c573c6"
    sha256 cellar: :any,                 monterey:       "14e4bb059f388a2a7f8b1fca9db8052834300b685e923fab82587b50edbc4338"
    sha256 cellar: :any,                 big_sur:        "3dba860ec03d2c36d6eee2ed8f58d8af58bc8194f47cf858859f626674386c39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12769c4944d3d171a8ced6eab5ebf478ddfd5b05435234f55bfaeabb25935c57"
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
