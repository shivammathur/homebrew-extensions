# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "e749c718ac3c82cf9c27d6a0303944a9cfa9ec2d6c2f3d6f473618d5f297d0ed"
    sha256 cellar: :any,                 arm64_sonoma:  "666dc09236eb4125146944aca46df43fd5e98aef75f62ebb1a215aba6dcdc75b"
    sha256 cellar: :any,                 arm64_ventura: "d5991a7dcb18679bf391b5ac4bc66219039f7850f5f29d52d8459fb43d2b3626"
    sha256 cellar: :any,                 ventura:       "8497ed8d7bc5f01cf7d7f089d1e91bd011a62c6993eee7515ec70103f9ea415d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fb880b904f808296a30a98eed4b1293b8d43cb58cd0d34bcdeaf387a9b997cd"
  end

  depends_on "icu4c@75"
  depends_on "openssl@3"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
