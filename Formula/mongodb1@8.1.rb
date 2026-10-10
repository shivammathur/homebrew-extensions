# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.11.tgz"
  sha256 "699671d3a36294851f9eb87a662dec226722f7375907727690d3e63bda6aa56c"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "54642d22120410e74d485df961fbf6b38eb1626137c9b83d1abfe95e5f14770f"
    sha256 cellar: :any, arm64_tahoe:       "027623e1eb746c2b3874db9b6b746bb4bc42e6e6259eff6665527d834970ad50"
    sha256 cellar: :any, arm64_sequoia:     "9ed2e7837490c066cde4ecea239e4bbd5c8fd009358bcc097766337eb2240dcd"
    sha256 cellar: :any, arm64_linux:       "ab287263f67a67980713d163516803592133f0214832fb13ec98c105f3742bac"
    sha256 cellar: :any, x86_64_linux:      "6238d529f6e7e74cb61f103a4e4cab50b4367d687a9cdccf7a40bb318199bb76"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
