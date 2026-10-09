# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "0a709c3fc874a0151a643c7abf45d1a003f671741aea3ce4723cc7c75279d7f8"
    sha256 cellar: :any, arm64_tahoe:       "328df581917254f008828fc6d6ebdc0eb2ca6556d785b487074a08dbf74154a9"
    sha256 cellar: :any, arm64_sequoia:     "8211bc1da5ded1dd8b6157a4b5bbfc45002c809f623979518792e7e722da91de"
    sha256 cellar: :any, arm64_linux:       "964021b51bf93deecbc5e34aae6851f534790abc221c5bd3f21e9814a6c8231a"
    sha256 cellar: :any, x86_64_linux:      "c44b83c06983133ebe123fb8f716a5d49a0f7f1a7a58dae9742b9ed928353887"
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
