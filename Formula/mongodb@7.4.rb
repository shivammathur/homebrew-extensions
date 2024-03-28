# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3b9da018574e8df235d6ff4d8260c186be3c12f97e2559b6ac8c9eaa23a9830c"
    sha256 cellar: :any,                 arm64_ventura:  "46294912407baa7b0b2834ca1c21cfe2dd1293fb3f151efd71e29d2b2e0598fc"
    sha256 cellar: :any,                 arm64_monterey: "cde29833e86384b7ff9dac8544a0d53302b6978a63622fdee17b47a015aa65d3"
    sha256 cellar: :any,                 ventura:        "d367d44a544b5a6313267de7de909137e68813c4574db6fe45e45570cc1232ec"
    sha256 cellar: :any,                 monterey:       "5a9f759fa108c5f3b83575dd8dd9bc9010df3c5e895324c0357844eab22da869"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40e7600cd41743ea77f3449dd622b154a88e255a8d09dc1c631ea3221dab7432"
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
