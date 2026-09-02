# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "78ffa75304443ec377a60b0ee9e46a7b4c27e3f631406f19df92c137a20cf10e"
    sha256 cellar: :any, arm64_sequoia: "9a3362302b7860317a7c4b46eb734bf134de0f1ea57bbafe7345b6d3038c657b"
    sha256 cellar: :any, arm64_sonoma:  "7e496089affa6eddce4cc5d43b1fc348418ce5545950bf0a9a1602b9e569cf81"
    sha256 cellar: :any, arm64_linux:   "7bd20eba1a2d77003b12bab157ec3b39640af2699900461146348d3c3ab7c378"
    sha256 cellar: :any, x86_64_linux:  "34697600b7ba9e6a9f36d1d086662a075bb2a4fd8d67c5fc06a20541cbb9b126"
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
