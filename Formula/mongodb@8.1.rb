# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.7.tgz"
  sha256 "0f46e64139569839b2becd30662a09843ffa9e99b8c4d006b2648a031a10fcc9"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6ad1a1a82203547ef736945fdeff3c1831f15be1731606fec57ea15e7b63090f"
    sha256 cellar: :any,                 arm64_sequoia: "fd09c5582dadb5cc42db7b27a92e92ec259398ed927e9a58d6467705d72fae1c"
    sha256 cellar: :any,                 arm64_sonoma:  "13dca78abe87e2ff58034f795d2f8e396f05b26b90a5c0086bf4a04b7f605149"
    sha256 cellar: :any,                 sonoma:        "4363ec76f4e0a5e842c716dd0bb718e21aa8daeb9f7d19bcc663af7c30f6cbfe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "29010ee27ffba54f48b8cf78cf2531f7e051a9be3f853485d5daa2000a8f5c3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "982c2d4e5d16915047ce8dc226c0149f4bedef006b643d6fc48f830e8ce6c09e"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
