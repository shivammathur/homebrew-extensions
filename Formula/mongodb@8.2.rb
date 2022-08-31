# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "5e4586761a1ba9e0d5a5f642f9c47b30cb931ec1776305d620b9d3740cf2a6b8"
    sha256 cellar: :any,                 arm64_big_sur:  "cd67effe97e619efc15a7a2561737255a8fddd7ed35c7a82f2cb4f693ac59378"
    sha256 cellar: :any,                 monterey:       "420690390a4c3eb159ef8716374f66fcda34c9016cb949fef55bd9f422c5e5bc"
    sha256 cellar: :any,                 big_sur:        "56cba751862dd67395af863e0f697c546c652954cb733cb1cc73a75b0f5045de"
    sha256 cellar: :any,                 catalina:       "0daec1e1784b664d8ba5080ff23f9c21e306eba6102f9411d65479618e06c00a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c2e754a5ca1c351a860053536980ab54671c19a0c6b5ab8645b2e473705c3657"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
