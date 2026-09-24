# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "3391902f29a7b8ae675d5a2d177a8dd72d5fdd8423b20c825b20b86ff72af209"
    sha256 cellar: :any, arm64_tahoe:       "426dec5a9578b4404214c6f4e5e381a5d2394e915d147769d4fab9e1ff702034"
    sha256 cellar: :any, arm64_sequoia:     "02b35ceb5d003e41dfbc43adcaa1cb6c41a350545eac51b8883cc9ca2e515768"
    sha256 cellar: :any, arm64_linux:       "401260435abb563b1ff263c92b9d60add56a2d00aeee97ca2cdbfd3c78ca1369"
    sha256 cellar: :any, x86_64_linux:      "d2e62bd30a4113d1597999f12cf814be50b29e9f0013bdac31a15bbcab3b8508"
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
