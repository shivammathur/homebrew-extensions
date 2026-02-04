# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.5.tgz"
  sha256 "b542e9285308dcd16ad4277f62a94cca2910ee57616a5a4f576ff686f3da4c77"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4fd73ef1a1f893b87a420fad30a88dcf99088e50decf13223f5cfa629b74a1ac"
    sha256 cellar: :any,                 arm64_sequoia: "f88d2acc822944d2833d038f3b372ade7a966fdb1bda3bd1288a4bca72023caa"
    sha256 cellar: :any,                 arm64_sonoma:  "26adb7b75305888949f0a6547ac27ba30deaabf196a8c044649f76a440f9f099"
    sha256 cellar: :any,                 sonoma:        "e53b82cbf0ac9f72e9ea2e579e271a492654c81a5340f4d58feb9a3c7ef464f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bcf4ed127db89ec763d761415d5561e77401b697305a558ecb43691e91db33f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0d9aa7311d8f36ebc79052b603fb80b3a3c471563a382c84d0dc12285715e85"
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
