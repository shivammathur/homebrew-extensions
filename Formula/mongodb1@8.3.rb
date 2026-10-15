# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "ef0f5f0af5503a7808555b13c039bb75b75638f979489763e6285d1113aea946"
    sha256 cellar: :any, arm64_tahoe:       "262c5436da7d36099ad046a471d023f9216706a0076c9eae0eca7c5b96213d02"
    sha256 cellar: :any, arm64_sequoia:     "03090d29845e4d2b5e347e123396f6cd8d84f6441ccde112f138639f4c7a3beb"
    sha256 cellar: :any, arm64_linux:       "bc6196ffdaa7e93a7de1b43d08af844a398d17ff485b28b8c9e686dcf7ee501a"
    sha256 cellar: :any, x86_64_linux:      "51fc91db4cf8c11a7a8bf7a7ff07d4c1304690d8cf21bd2127625576740fae20"
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
