# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.2.1.tgz"
  sha256 "b923617bec3cde420d80bf78aeb05002be3c0e930b93adaacaa5c2e0c25adb42"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2131b250ba8b052f496f0b0dbd89865b32d007a203bb17794ce3c952b9ba7dab"
    sha256 cellar: :any,                 arm64_sequoia: "81277bd5f1c3e63f6bd0a40210cb05784687cd9523f492bb4f91417d4b705d5d"
    sha256 cellar: :any,                 arm64_sonoma:  "dea4e6326a97977d0873b34a3d07264fc5e007582e3809baf89658fa42815866"
    sha256 cellar: :any,                 sonoma:        "1d13d316bd7230841120ed6100a41c219125ffd9739c9a305d0a19dcefb00888"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0fc2a91d55deee38614bf2155bb0d3f6a7dfab3ff26011fa1b03726650e289f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fba63b25113b624111eb73455a519b89e1bb2cf15a7c32a65a0cef62bf4ac6c"
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
