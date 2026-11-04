# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "47068ef4ba3549b03fa6d559e9f7df813212f53d66d4d20bc272abdb1715d2f8"
    sha256 cellar: :any, arm64_tahoe:       "a5e9eaa0db9c2c7b907b263a8efc303e030f33135e70ed2821e04beb60c22e97"
    sha256 cellar: :any, arm64_sequoia:     "af4b4d7a98d8a2bf3c6b741ed2f3a50085f4835817028881c489c8fdb39683bd"
    sha256 cellar: :any, arm64_linux:       "fde512b340f7f93f2af6b80c3652750c3fc2f649d8d7681b7200e7fe68356a77"
    sha256 cellar: :any, x86_64_linux:      "7a12dac5d3ce969fc60978d839bf6b82503cbd8b45888e0ea392a64a6b6d4c36"
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
