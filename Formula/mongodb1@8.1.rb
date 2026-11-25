# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
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
    manifest_sha256 "86b30293f66453ea757a4779e033c02b5c4c77321be21553e9a377d4b41e20b8"
    sha256 cellar: :any, arm64_golden_gate: "e1c1e21700714da4553b8e2834d0e36af2d1795f94942e20dd1e7d8ae6b08284"
    sha256 cellar: :any, arm64_tahoe:       "68b24798bffe6c27c08cc4a7d448ee21408ac93be7a359d1e38117158f50f95e"
    sha256 cellar: :any, arm64_sequoia:     "1be0ae119ae077412c5f821c9f4c0d2b836f0620b04e08695239ae06246c935a"
    sha256 cellar: :any, arm64_linux:       "5af82d8311625d7fd89036ed4e36fb858dfb8109e21b61eb448b1a7d57bc633d"
    sha256 cellar: :any, x86_64_linux:      "72a10fea6a9002be3f0dda043e5e20d5cb658229be3a19424c7bab72efe05311"
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
