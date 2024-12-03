# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "84c01a4514d97dc265541e65faeb44ed9e09701f170b97c256af1e06fe852c7d"
    sha256 cellar: :any,                 arm64_sonoma:  "f587a8eb4d2cf1a48fdb7ef43a9288692ecc7743f7ab0d9921fd01be010b2295"
    sha256 cellar: :any,                 arm64_ventura: "96f84b72ee1b84a68d75333a7abdcfc60be5d166400e92e00ba5e3310299c6d6"
    sha256 cellar: :any,                 ventura:       "16cc84d353fac3a34d595984efb4922c1e32e5e728e5a3b56f7f0b7abc5485de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "360fcf3ef85bb62a0c59068e5280851484f2b51f72bcf831966987f7bc187872"
  end

  depends_on "icu4c@76"
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
