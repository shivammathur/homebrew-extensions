# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "02db68f4488a217b799352af660c287d844ee03f02562c26cc2d88de277b9edc"
    sha256 cellar: :any, arm64_tahoe:       "caf8563ec992a44988000bf6a5c013a95e361b26576402f99d5c1644c59b15e3"
    sha256 cellar: :any, arm64_sequoia:     "e44088238baf4173079c7a6c6b195ce8866257e241ae548c78aefa3959f46bfd"
    sha256 cellar: :any, arm64_linux:       "5195f2e236a0e10ba4cfc822a11aa5c39e39294762ffada1a29434a379f1719d"
    sha256 cellar: :any, x86_64_linux:      "6e8556b723745709ed041c966da346f7a1f4106095a575ccb0ca8586b0f6d6e3"
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
