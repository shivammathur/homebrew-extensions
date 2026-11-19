# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.14.tgz"
  sha256 "4d918b07ebf3bf2c237fecb70c13170c282fca5df627fb0b7d3260b003f46495"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "27c9baf38ea22c9b01343302cb33bd27c29af52255a279d0b01875d08f5abbd5"
    sha256 cellar: :any, arm64_tahoe:       "b3c7c55c74cc7eb2b5b22a6e23e6eb2b90be8ed2103896665454b85fe43a2b5c"
    sha256 cellar: :any, arm64_sequoia:     "0453b707519e20e1c7df9eec01d06bd836892239261e3c7c9a6ea9287c773a9c"
    sha256 cellar: :any, arm64_linux:       "a87ebdb8a131ccb902f1da9de47fb1902c0faecafff588a4dc46ea4697e18788"
    sha256 cellar: :any, x86_64_linux:      "8c1ab00a0e4d43a85a27e61f97a65bb21d90a45268c15b033b8e1fdfc39f0c2b"
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
