# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.4.tgz"
  sha256 "ad299dfc4f69859acdb82d7eca5140833370dce31ebbe2c628e716ed3167b841"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "77732d28aa32fce79e2474a8d01e5ef2a75a63229582fb9e025c84388b8cee67"
    sha256 cellar: :any,                 arm64_sequoia: "0052164ccab4238765df90ba8a445566758620811ed645b71f23b96d4fd26a9b"
    sha256 cellar: :any,                 arm64_sonoma:  "14965b0f768d9ccb33c5867bfebc4e9f8e359d88614c423923f852caf94c978e"
    sha256 cellar: :any,                 sonoma:        "4b0fc80e58bdc6989f3df7223d93b669f4d376f939450b602f6643e2d315ed52"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8c91ca190e02ba9c2312102f33d9d5d62e04706c9b2b08cabc1d772a1e7306ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8570e542584d7b732ebf8c01d6ce51f60791eb07cb7313d67dce2f57e59be96"
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
