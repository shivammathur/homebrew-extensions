# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.7.tgz"
  sha256 "078773856f4066b56738fc13950bb7ee16b5e66f727fb41d3fbec6043c78fd32"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4a5bf085859725d094d8fabda4a08458ab2a818638db503ee72da25e4fd66f95"
    sha256 cellar: :any, arm64_tahoe:       "7a7138140d0710ddda34c7d8ae1b0f1d5e2cc60e8882c8907922b570a6d10bdf"
    sha256 cellar: :any, arm64_sequoia:     "6c129b4ef1060952e3d5f1d13c384c40ad99263432945a495c7397391a5ed65f"
    sha256 cellar: :any, arm64_linux:       "5d7436cc2a614387851f9e5f2c653bc5fd92252d190ca1527c76c59465e48dd5"
    sha256 cellar: :any, x86_64_linux:      "4725af213dd57b712f218910c519cb9dbbcecfcdcd4becfeb41c90ac4e2f4ee0"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
