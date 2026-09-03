# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.8.tgz"
  sha256 "41f230589370ffa60a23e3443cec6493e556f8a7d74d42ab5d95fc65abe89856"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c5cc43f6f71f4255962a790c17d018a1fcc78158c0a4792b896cf2c85491132d"
    sha256 cellar: :any, arm64_sequoia: "a632406de2e55347e903cff4e2145a99a64baf05590c4e14263865f7bbaa1323"
    sha256 cellar: :any, arm64_sonoma:  "0ec8ad6ab75ee556d4299c08e072145e07075035ceed4344eaaa973815b5a2fc"
    sha256 cellar: :any, arm64_linux:   "508cfb17ee5b452b77d8d194a8d05b2998dcb4070426101aa47b17536aa91fe4"
    sha256 cellar: :any, x86_64_linux:  "22e5d4f321ceadfb7938d9c8d3be67c7dd4f43ea739009ca7ce0c540ca885a37"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
