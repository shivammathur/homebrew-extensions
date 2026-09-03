# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.8.tgz"
  sha256 "41f230589370ffa60a23e3443cec6493e556f8a7d74d42ab5d95fc65abe89856"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "2bf9cb59ce2520ffa775e4b4745454634a2c7b42ee53c4b7848d4cd3a1881fd8"
    sha256 cellar: :any, arm64_sequoia: "3729c6e8b222ff77a35e93c00d480ce3ac45838e3c3fdb5bf8b94bb9ac1411ab"
    sha256 cellar: :any, arm64_sonoma:  "fad6686190223e5ecc73e722ce63419c732e7f072b9761588e19e657ee917bb9"
    sha256 cellar: :any, arm64_linux:   "1acb3c88b50e7e44b8f252501d66a89328d834d37682230dd3f6bcdc078cb1e3"
    sha256 cellar: :any, x86_64_linux:  "76c52b57692d71ec5a5c1ba9469a17e4aa765e36afae6aef391cd41799d7a707"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
