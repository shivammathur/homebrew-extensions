# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    manifest_sha256 "fc1d578bfa6929eb87f3c3959c1b5b0d5dcc2d6201761125741bad40f61ff067"
    sha256 cellar: :any, arm64_golden_gate: "1b092f49c1e38c0976f240f676704d3d23ebedc605a3f55bdfd8a4222d6bfdb8"
    sha256 cellar: :any, arm64_tahoe:       "cbcaead63b10f769f2e3b39681e86533c7db02f43e221747543fa9b49b392acc"
    sha256 cellar: :any, arm64_sequoia:     "f56069b00d1d037537d43a80b0b6dc7629787e626eac14cc69f2c9dce665d1e6"
    sha256 cellar: :any, arm64_linux:       "7d2727a644e3ee6873800af725cb9446f6e21837644ed118eaeca28b76b8ce0f"
    sha256 cellar: :any, x86_64_linux:      "86a98e6917670ea741b004e82fb1159933531a4a20959c02687c5341c9ef651c"
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
