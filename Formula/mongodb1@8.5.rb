# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "44cb6aef3b59aaf406f3a981e0f455f65c7e92a27d71f664de899106fd14aa69"
    sha256 cellar: :any, arm64_tahoe:       "6581c030ede39dde4e7f2e3d7814e21d0b3786be5e6b510f5700d082920d4adf"
    sha256 cellar: :any, arm64_sequoia:     "3efb15c69d20a928375b7d1facdb9e93a1e5a13398859e8c958537c17b86756f"
    sha256 cellar: :any, arm64_linux:       "eeb29048a312201c5379ff06078c050de513dbff36894280b09ea88aba6b8b84"
    sha256 cellar: :any, x86_64_linux:      "ca2ae9ddcf251854916c02ece8bad4cedd783635a6cb9448119725efcbf9eccf"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
