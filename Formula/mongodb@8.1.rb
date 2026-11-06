# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "a15e03bb3640e1658dfa4659a2645f8112ce9ed868a60d3cf98a7286964bd4fa"
    sha256 cellar: :any, arm64_tahoe:       "de5793f9216c5c48febf2dbc79119d3f853c415d0b37702401e7d5676c5bc251"
    sha256 cellar: :any, arm64_sequoia:     "d76404072abf6a548cba660a6cfbf2ba3199601738616893441203fee2ac996b"
    sha256 cellar: :any, arm64_linux:       "c4a7d44a1a54aa3c94dbf99befc45e369adea4aa0ea336c140a7bff5d52202a0"
    sha256 cellar: :any, x86_64_linux:      "72c0f865a213b426d89f0a99c5d9c9e0708f15aaa3f91358fc4caf1f0ffb8b75"
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
