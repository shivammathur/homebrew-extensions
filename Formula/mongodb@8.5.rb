# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "6d755fed5b939bf89e24234392e9ad470efd0fd4aca6e8ad15165e68bb7fbabd"
    sha256 cellar: :any, arm64_tahoe:       "e5eb0a7d9b8f7049f54a781750cf93d0f07e7d6aaff72fd924a1be25b8714a71"
    sha256 cellar: :any, arm64_sequoia:     "b3200f55a5cd421f94eccf98fe88c3f88a58cae47624ada974b6f8430d5904ce"
    sha256 cellar: :any, arm64_linux:       "e1e9c06cf33bd4d089e8433c71c952d3a8313834aa1a39d12d78f2665668bd3f"
    sha256 cellar: :any, x86_64_linux:      "3a3ead4f3e87b58946281c75e6b195f1b86011acecbc1fd4f77a4b7b582478e9"
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
