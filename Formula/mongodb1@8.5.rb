# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.15.tgz"
  sha256 "97772e6a0f2019eff7856522464e4432984f4fec470eaae14b807d70809b477c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7abfec618a9cb270e7a30648a23da5c47791e5add5d9b22ada58f02575c09568"
    sha256 cellar: :any, arm64_tahoe:       "91d9a7eb71e2cef54d267ca46298ae7520c6bca848c3de9b733561e5b83c8ac1"
    sha256 cellar: :any, arm64_sequoia:     "705e1e52dc9fc80cb5b0e9024bf37d470ef0c48ebb3b3dee61d75b5c8e8afd33"
    sha256 cellar: :any, arm64_linux:       "b9cd3234ab3072695ccfc26e7c38a0da9b7404c139ec836eb2e4d7f88682a158"
    sha256 cellar: :any, x86_64_linux:      "022b88a9a2fdaa72678eb5aa541b6e2d5f183e4e3fc66bf7cc1bf47fa7dbd3eb"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
