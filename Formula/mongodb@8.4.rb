# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.1.tgz"
  sha256 "bea8eb86be7e301b1cd3935ee3ccfa052e410a7cfa404ae5ab4b11e4c99b8899"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "58cb4f9e6045c137fdde3f3370a796673330b9d07febe8a295110cd4af58e799"
    sha256 cellar: :any,                 arm64_sonoma:  "8c417bb57e6647d18b3944fc8d23f31c52446040c96a0d3f7b988f3b1455b1ff"
    sha256 cellar: :any,                 arm64_ventura: "2495ce59078dfdf65694788adb5ceb589afeedf5bb94e298587b812aeb399c67"
    sha256 cellar: :any,                 ventura:       "9f0b96f7a84f9da4e70263d4d6c1fa813c9446dd0d62d427a2bf257291940c1b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d3fb609c7568f2b302e02e6bb96de7ebfcedf13d2b1998e4b4cbd3eca1e142d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4fadbd2d98edb29195099c4ade46b2401a7a531175ff0eca3b73c550c0cb884d"
  end

  depends_on "icu4c@77"
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
