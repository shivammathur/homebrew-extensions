# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "0739231753c8c58ed1bd6cf5f69f62acd0753ed30d0bb487827a2f4946dd34c9"
    sha256 cellar: :any, arm64_sequoia: "97f5c882216d8fa0594b0e3475d5230f46518b37b4fcf146f86fc3f897611c2d"
    sha256 cellar: :any, arm64_sonoma:  "20d9e7b8c2e1954f9a7b59f5d7b1b703c2e88a428c66bce6f263ee1c292c8f9e"
    sha256 cellar: :any, arm64_linux:   "d0155c91eb84e725c9715b6af73dd0531dd6303650b86ffbba8320e26be71a6c"
    sha256 cellar: :any, x86_64_linux:  "17c0cdb443b9dc8d904bdd23b231ebe9576d636cb018e3c73fe60ee21ab0f3f4"
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
