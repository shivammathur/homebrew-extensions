# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "11bb28e2b1a2e7929dcadc484fcd8400846763a58d1f18b4ff6fbef5f13bd8c9"
    sha256 cellar: :any, arm64_tahoe:       "88c28e3a99fb0af16079134abaee85fead5b504fa14fa74efb0a9c6efefb4508"
    sha256 cellar: :any, arm64_sequoia:     "8667287b0318bb1638e991409841e93056c668e2ebed1a50b45034666bec1d22"
    sha256 cellar: :any, arm64_linux:       "ff658e56a2791a6ec68c322cf0581ebb77165badc49290f1f9792f9cd2548825"
    sha256 cellar: :any, x86_64_linux:      "927bc98490b9b83742dd2754f3bb9cb6a9a2875a4a68b0b7d536821ee2340d01"
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
