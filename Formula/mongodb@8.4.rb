# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.4.tgz"
  sha256 "41eead0799cc66876b12d10b5efe86268bfc704c1be57a70d49e4bd4bf6c8ee1"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "40653d32a89bea63c069fd7b9eb04db4fc7df466ab4311e67f5e0c69d73d5dd2"
    sha256 cellar: :any, arm64_tahoe:       "e5c4bd9f91374744bc20ac6e7d5ad3bf8cd1197fa4975fb2ce8382a415b95f8f"
    sha256 cellar: :any, arm64_sequoia:     "868bd2e12267ea7af3cb1555f1965b20aede2e05f2081268445fdef6c78161be"
    sha256 cellar: :any, arm64_linux:       "f1fd07753ca1533d1265bca206e19a11e4d07769122de3a0d21c0085939c7fca"
    sha256 cellar: :any, x86_64_linux:      "4361f173e05f9da7d2ef11bd37041367e0c7ebdbcab09c798dae348500e9e0b3"
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
