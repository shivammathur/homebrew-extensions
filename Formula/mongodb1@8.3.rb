# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.10.tgz"
  sha256 "316a6027f2dd612771a4d7e36d6bc9e8e96c7825a611fcc8b7fc5f270ecf6705"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6ad08b71eeca55faee112509bff8f5af82c39adbb6cfd87061ce4e3d148146cd"
    sha256 cellar: :any, arm64_tahoe:       "911c4cdf2fd3826199339f3a7d16889909d3039efa29b66e9f34fdfc57781e7b"
    sha256 cellar: :any, arm64_sequoia:     "a606ddbf6cd810d3a167cc5b63a47d7d2c8f2d23586f10fabb223dd1f496d73b"
    sha256 cellar: :any, arm64_linux:       "6e4fb643fd4d43a8d71951d3aec064f8bbb047dd126359562e30893463bcd64b"
    sha256 cellar: :any, x86_64_linux:      "08f0a7b5f8863dd232acb7fc79a3ab7c64df0de95f4fc0856d5b4e58cf000977"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@78"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
