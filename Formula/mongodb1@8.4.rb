# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.12.tgz"
  sha256 "d4d2a8ad034685eacd7ea3ed96c0c9aed8c0165ea6e79d106bdf95214d5eaa35"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "eee5c7c54027d38998ce763ec651b5d364d993573c64a4b232cbc49fd54d94c2"
    sha256 cellar: :any, arm64_tahoe:       "7a7dbd1b68818030a10e2f0af36cc64b7dfdb877f150675ab2630cf7630c4d10"
    sha256 cellar: :any, arm64_sequoia:     "e951be405182f66654e9f43140243d79d5224958185f48f1a678900cd710c747"
    sha256 cellar: :any, arm64_linux:       "c7514abceca26bf287cda260419e140fe11c9be5b9c653a94a17f5961a9353df"
    sha256 cellar: :any, x86_64_linux:      "e961787cbafcdfec4b1f8df09f28048167c43651fbf1169e50f8d3896a5e4650"
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
