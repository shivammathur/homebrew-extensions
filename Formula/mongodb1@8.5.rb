# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "28b6eac02283737d7ddaed6cd2655d7f6537f400d858a5535d123c6e3d7f54f0"
    sha256 cellar: :any, arm64_tahoe:       "09503d94f2aaf0fbeadd846f0b77e572add871d731f2a7c99e6e2fa251970012"
    sha256 cellar: :any, arm64_sequoia:     "ebf1746b89f42c67aa2acf1a9451946b84001197d6727aa2c812ed6f94975908"
    sha256 cellar: :any, arm64_linux:       "b202b5905e4b9968a9205bf9e07d51ca61c3bb35d12a597a54aab958c5fd2abc"
    sha256 cellar: :any, x86_64_linux:      "22a63d0d523425b15c18700512093a35f12196aa398a5072e39999f2e3c04a1f"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
