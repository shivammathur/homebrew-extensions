# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "55e46f9319951aad02cc003b67a45d7487793ec242ec7460edc635779dfe0c9e"
    sha256 cellar: :any, arm64_tahoe:       "c8a20417e6d67aefa9f98f651d1fae98a5c530f15783dbfaf7a44440e6748045"
    sha256 cellar: :any, arm64_sequoia:     "c1e0df5bd612ea362b7247572a7cbc04c946c9b57fc8856dc93f0d40c7016608"
    sha256 cellar: :any, arm64_linux:       "2d429487b38556f68ff42ec45044540327f740550df1698037c52828451fd06b"
    sha256 cellar: :any, x86_64_linux:      "f723ff42db9a563cde20073fa065d0a56f07f3530f86b94fcefa272cc4fc255e"
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
