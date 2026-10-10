# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  revision 3
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "49c32f405236d52cd949de9236d3dc00f85578ae8626ee04618eb86946f578d5"
    sha256 cellar: :any, arm64_tahoe:       "f208e30163b22d3c84d864f5c80cc92f92d7dbe213d83b52275f921e36b2fba9"
    sha256 cellar: :any, arm64_sequoia:     "40706d198f7b67b245a0bdca46b829c81d82c19f9b3aef6ba715bc0b4457bc8a"
    sha256 cellar: :any, arm64_linux:       "2ace63652bbd961572a4deb623e6323bd47a9425417fb0c77788f6cc4ad9d710"
    sha256 cellar: :any, x86_64_linux:      "740d0652a6274aaea68cfc0260110e27f8b3f852c8f54d241b0d1021db3a12bf"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
  depends_on "openssl@4"
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
