# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.13.tgz"
  sha256 "317d6ec24e8eefa741405002cbf788b8549ad302c630c0c7b08dd445940da5c6"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ea2d72fa4149b1f6f11b0d3db013ac10f60b25241c74cfd139d32a070d477e26"
    sha256 cellar: :any, arm64_tahoe:       "162332899c3b848b667130de2da88dd0b3c8d48f60294c64072abad80dfea5c0"
    sha256 cellar: :any, arm64_sequoia:     "203ddb6bf8eac2f90113a6b43cc433db39ac9e7db80084c7bf0bd9073cd75e97"
    sha256 cellar: :any, arm64_linux:       "87c25e1ce175d4faa0734963e13c7ae19043cc9b5e1cdad2119becc6197bcf59"
    sha256 cellar: :any, x86_64_linux:      "7f928840f83f4edbbefd7200cfda04d6e3946fe12624f0dde7497a4fef92ef40"
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
