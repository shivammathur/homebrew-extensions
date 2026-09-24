# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.3.tgz"
  sha256 "5e5369cd01b47543fb3244917eff17fa4c8c357b0866828d59c899b4e53e6665"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9acfbbe8a390c42c2462010cc1b0c99ff202f56326db2458298ae32a2ee99e32"
    sha256 cellar: :any, arm64_tahoe:       "ad833b9e7001fb312106bc26fa382b6537165393e19397ba6c5b190fad8f64df"
    sha256 cellar: :any, arm64_sequoia:     "eab43f69cbbbcfabba91e8fec3aaf9cb26344a9149c41af92e8265d13dd772ec"
    sha256 cellar: :any, arm64_linux:       "29ff020555ddd63a101d78db9a0c98acaa20b8facd8f3da709964ca0b1ac5e2e"
    sha256 cellar: :any, x86_64_linux:      "ca9a5c413cc77ec068753f8c6f4f4f9f9d2383cafd18098649e9df4869b58f37"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
