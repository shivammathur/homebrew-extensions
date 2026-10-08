# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "fc7db4f3f75235fa6645be8a581ffc88ffd3d7b3a177d235a5470a59301755ca"
    sha256 cellar: :any, arm64_tahoe:       "a1abd7ad18f90193c8ef4de6e8435d371bf1feb4948af87b3daecd9e888ec054"
    sha256 cellar: :any, arm64_sequoia:     "0c74b7d9e785d39423b01bf61cf086c5448554e7e35051be29442b5db0171bc1"
    sha256 cellar: :any, arm64_linux:       "85cb46f174e3f5997474f85c23dec1e9611325234dfa64a81f57c410baeef605"
    sha256 cellar: :any, x86_64_linux:      "cb341d78db7fd631cfc9617d2bb133c4faa952cff931d378a6145235edb31104"
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
