# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c933e936521d6a1ec574e964a04c725c0043629b5c7feb43399359dcc05d92e0"
    sha256 cellar: :any, arm64_tahoe:       "66ba2fd0a68a068d40c1f14431d604d6fb52597378de6db7ba2d7b852eafb45f"
    sha256 cellar: :any, arm64_sequoia:     "c5989fe73c5a7549d73a849413474275e939def93c74ece1d55f4720dfccf98a"
    sha256 cellar: :any, arm64_linux:       "ec4bd4a7fdf068ad2264d2523e9df6e9548e549dfec8f7718bc2f802331a7af4"
    sha256 cellar: :any, x86_64_linux:      "8c0cdb0107beccbe2cd520a7f90efc0b8f6675151b643ec8559a368628784710"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
