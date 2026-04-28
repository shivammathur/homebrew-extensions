# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.0.tgz"
  sha256 "7e7c4fbdc991bad24524316096d4ac9cd805632c9ba7f9886682db843d60166c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "91e0b2282c671ca657b458f9f8a7482ce1286f1c49aada25e9eea32381e4b72e"
    sha256 cellar: :any,                 arm64_sequoia: "9b21f8fc74ca0c99519810515189a65b706b321d8bef8a6e1a3ea1bf8f8f2853"
    sha256 cellar: :any,                 arm64_sonoma:  "2aab564250ea0b0bda5e36e17c2ba64ceb289adfc99e6d2c5217796fc4573b5f"
    sha256 cellar: :any,                 sonoma:        "15b445b20303c48dccdf905644e824ebd4886bcbd0bcb22ef9d522ef3f907f80"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2d7e4dd2eff40eef2c5855dcbb18e34ae6fc40aabf56c91551a59668d2424cd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2281d32b200c05c18106faf072733040bb63099d4288f122b35ee4bfa764c75f"
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
