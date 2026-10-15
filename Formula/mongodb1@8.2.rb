# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.12.tgz"
  sha256 "d4d2a8ad034685eacd7ea3ed96c0c9aed8c0165ea6e79d106bdf95214d5eaa35"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "627bf7cea2722b186c9bf16dc9c38701b15b6d2615e84043a4d62578e0744278"
    sha256 cellar: :any, arm64_tahoe:       "edb48eb2cb2f3a5ef73e8ab34e97830a227b78dd947f2000a3b8132b8929f93d"
    sha256 cellar: :any, arm64_sequoia:     "a5738c00b6cf77a408a31244eac436d4e2053deaf17d79e715f6915a2252be53"
    sha256 cellar: :any, arm64_linux:       "750b1a97fc253a455b00f1f94a6847d6d0484066730fa5d2553fd5c3e2ddeef1"
    sha256 cellar: :any, x86_64_linux:      "d3a931ce7b8cd835719b9881e0135ebc7a66d93e8a2f5235d58058041d686e9a"
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
