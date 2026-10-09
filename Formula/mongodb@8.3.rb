# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "f1e78a01d0d2871b38f2c40f1523662009ed7f10a5b1477bb37ac68919861854"
    sha256 cellar: :any, arm64_tahoe:       "71572431f1437acc85726f6bc50dd8f7529b53bb1ca8b41f1f96ee28a6819a36"
    sha256 cellar: :any, arm64_sequoia:     "57a87e416c6fe954fded22eac364e6ca50522d12f0d53edef6fb0418b26ce2ed"
    sha256 cellar: :any, arm64_linux:       "68371d9fba977749307c6f8736aa267218d6b5bd253ff92ffde764c6835b6818"
    sha256 cellar: :any, x86_64_linux:      "1806f46f0abb6a19eb0e444ac7bfa70a75d031f7d0a5b3a31efe5cb10e85862e"
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
