# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "71d1dfb3ef7e012de4953bc784a7e0314a5d8263217f99bb8e4893167eaffd00"
    sha256 cellar: :any, arm64_tahoe:       "1b9e353473de91ff6d69e35998833e6ff3a2b495d9fb8a353c8329441ba71f41"
    sha256 cellar: :any, arm64_sequoia:     "f7903fc60b47a9eca0d0b038b23f0f4e236a0d8b85fef6e26f89d74246f273c2"
    sha256 cellar: :any, arm64_linux:       "2cdaa5dba1bea92439b9d052b91e5d3586f1fa5a628833469c0d2d5276097349"
    sha256 cellar: :any, x86_64_linux:      "1d9e0cff313ec62ecbdbde7715fe4caf2388f7ea8aa44d10bcb24f3576af123b"
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
