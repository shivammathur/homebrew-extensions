# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "e6eb0c35e328e2d5b2aecb5d50aa520901b8c03e04a96cd14f46029a8af84e57"
    sha256 cellar: :any,                 arm64_sonoma:  "cd676067df49abfe17a3ba47c66120b5bf2e312685751c7e75c2a95e80ef9e95"
    sha256 cellar: :any,                 arm64_ventura: "316d0a162a8ae8ce77e05216127ff891b8063fa133585880eb712478c340cd76"
    sha256 cellar: :any,                 ventura:       "bed1d323f3618adb8125dc96371b2570741aecf3c4cc79bac5bad9e19a10bd10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e0f46bf6ef9cee499fa130ed7e62ea8c0674a8235d94d3b9e9dcf368feb6cf8"
  end

  depends_on "icu4c@76"
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
