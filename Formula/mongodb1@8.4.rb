# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "85fae985049f3aa9f25e3865416c824749b174e38cc47c784caac74ad67bf1ae"
    sha256 cellar: :any, arm64_tahoe:       "64ff572b4d553ecb52f78eca22d96ab29c2806d17e74242aea214960c5e29e0f"
    sha256 cellar: :any, arm64_sequoia:     "d427aac340f7bab50f1ebaa48da0f7ca7c5461b0ca564fe3e4b06a5e4df15d91"
    sha256 cellar: :any, arm64_linux:       "a97c9b56cdc6fa7cda00658da1447d7df60525be92052807675814d574b82077"
    sha256 cellar: :any, x86_64_linux:      "b2afe1dd8645bad4174075dc3cf200049f578ba94f9d3daadc8ba22a41be75a7"
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
