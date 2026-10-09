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
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "88d9ce1833f88f1a07a193ec6a24fdfb195c11c3419047df4d25b37ac984ac8f"
    sha256 cellar: :any, arm64_tahoe:       "84d75f306480e6f900ce605dab2dd666bbcfa1db245f41d5226502e0cf17b7a3"
    sha256 cellar: :any, arm64_sequoia:     "24c770e615bb4b96222d70933a22d64ee7fe2894ca8ca31b9ae6fb169533fe54"
    sha256 cellar: :any, arm64_linux:       "6d4aee8df3702c147bd0d2171e0e5ea1d4c6f3bfedb5854d83ea7afda205a0c3"
    sha256 cellar: :any, x86_64_linux:      "e795c2239a790a380d8634b2f7d799b27b6bc3f9f507558e2ce4c5412bce86e5"
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
