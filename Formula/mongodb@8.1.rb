# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "2b21a2c0133b48e31790aa3ad006fe7535127bd6a781ba032603837c21dea087"
    sha256 cellar: :any,                 arm64_ventura:  "4464fcbf1cfafb758431754318813d178da1322205c119971ed847648a70f918"
    sha256 cellar: :any,                 arm64_monterey: "b22ec685f73f9d0e8acc116cfc71db78ad4fe7d9aa8728ff7e0bbd6016d048a3"
    sha256 cellar: :any,                 ventura:        "b266b41f6b1182a07174116f57311a11924926146ea6f4204f043cf0cdd3e4ba"
    sha256 cellar: :any,                 monterey:       "52d289ac4a5eaa23daef506b48c7f06ca01c6a04b1f40c23847487c6f1560597"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9d29812a368324090b299e9fd2763d784681e7fd79887d32a1bd1afda822e5b"
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
