# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "f934b39ec1673b5f25ccbbe0a10ce0368b706a35a44cf37dd0340821ae53f2eb"
    sha256 cellar: :any, arm64_tahoe:       "3196c250a5e109fd5053da03a6d0010228c7ca2e2b66cbf9e418df37df22d5d2"
    sha256 cellar: :any, arm64_sequoia:     "f7ce081a535b0cc17de6c144f6519ba033e9fca9be822c81b0bccecf0ef5582f"
    sha256 cellar: :any, arm64_linux:       "4b2bbb84ad958c6e4573f90172e368f7ed1fdacda1e058dbec12557434fa9ff4"
    sha256 cellar: :any, x86_64_linux:      "b81f3874d60e81d193c06a76492b64ccc30f3f8f2c8f29ee6afa88b66eadea96"
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
