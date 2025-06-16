# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.1.tgz"
  sha256 "357e1f4f6b9f6f6970789f5186467da1960dff2db2a8d6474f69ad51a37b5f72"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5a1033548f3a6b4b527c7e81a2e8709260265fcf34c2fab3d411aca6dd001875"
    sha256 cellar: :any,                 arm64_sonoma:  "8c0d15832aee563dad4b97cba4cd34e94c80543b1c4f5a4fa8e5bdc2fed8880c"
    sha256 cellar: :any,                 arm64_ventura: "1a75152957af2d85385ed7e78407fce35cdc3056cb755b81fcc60142e5dc688c"
    sha256 cellar: :any,                 ventura:       "452448a26e89ff4ca63f0ed2c056849f8e186db56dc607986a0451a1b766789b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "40cafe21a9d11c242b5313006d212c9e4bb64e5f6295bd76c98df8b5cf80c17d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a10ecb4fcb2dc209e99a39b7b9846ccd1700337ecebe604fa532056aae64137d"
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
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
