# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ee16758bd09a196e8bdca3b8d29191acae3b86dd192229ce36689c89a33b4e2a"
    sha256 cellar: :any, arm64_tahoe:       "af82397a5668d90ac03dace7bd96d9ac7eb717ecc8b6c4104f403fba461917b3"
    sha256 cellar: :any, arm64_sequoia:     "6ba831072934330238f68a2bc4845cb7681d3d62ad21b0a7bc0ae2b040406814"
    sha256 cellar: :any, arm64_linux:       "2ff8457e9521b2c7e6925296e42f4a40343f2f5ff2a20d12adc600a1a54e619a"
    sha256 cellar: :any, x86_64_linux:      "72047479fd5dbacf1083a46936d4b789769eeba40e3b391fa9fc60dfb3c75485"
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
