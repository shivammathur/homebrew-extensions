# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.3.tgz"
  sha256 "6ef901d143a739c0769fad5b1bcd92646baa094d532e43738b48a13039ab067c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d63f433c685be95be81d0415b58f248c2c0bbfe05d000816e30c7b03de43e1aa"
    sha256 cellar: :any,                 arm64_sequoia: "64bf0db1a1d7083200df4cdcc9976f4f94b566aeed45023b56fad4472cb023f5"
    sha256 cellar: :any,                 arm64_sonoma:  "ce760517636909cc4358d2e8cee07d55d2ef4945d965f4f87c9be19d4b8c5986"
    sha256 cellar: :any,                 sonoma:        "61297ee26216deb606b56b724dbbb802ec06e0f13ef2c976445bd43cd8c148c3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "374cb3f1a12b2cc545cd5e8638a931944415942d870928985047da8d85676bef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43c9e049835967bcd93c1ba6daf72cf813177889ae26bd99d4e18a2927fe1bc3"
  end

  depends_on "cyrus-sasl"
  depends_on "icu4c@77"
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
