# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.11.tgz"
  sha256 "699671d3a36294851f9eb87a662dec226722f7375907727690d3e63bda6aa56c"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "55542c9cc67b6ca56fa1cd3367cbc932cd53e038d9ab45eae8a0762d5e733b33"
    sha256 cellar: :any, arm64_tahoe:       "02947ed6fba1a03ddd11b7e60197d4a7ed6cb9cc28fe528c571277b2c8582e74"
    sha256 cellar: :any, arm64_sequoia:     "078641da64ca0842ce743a086cd2b34e0cf1b9bbc1d85457c4c73e1459876720"
    sha256 cellar: :any, arm64_linux:       "009750bedffc32d2991190eed510933261748c982af18d966cec5dee22e7451d"
    sha256 cellar: :any, x86_64_linux:      "3c7b237b9d098449889255bff4c24ee7379eb955ce272773ac65e39534b117b4"
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
