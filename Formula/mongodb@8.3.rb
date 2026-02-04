# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.8.tgz"
  sha256 "fd0d34b4c530bad6dc4e0be61e23c118a3cc851ad879e088d6afca25b574916b"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "657077211dc2a7f44401d712cd296309bacccdc944a8834183c73a0a4ac6d2a2"
    sha256 cellar: :any,                 arm64_sequoia: "6a1a9fb3d179f93af401b7f9741262a2478c78545f8ce47a230e56ff17a0fa7d"
    sha256 cellar: :any,                 arm64_sonoma:  "65e7c109d6529c3bf269f3ceb11fb371f5ff8b4c0dc7f94fe0edc5397755ba28"
    sha256 cellar: :any,                 sonoma:        "1c4605068016c740f68999923e5e7bc443944b1909497cfaa7c34e63b35cfe98"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "47c456826b98ebef4aa690abf881a8379f1e096afa36e7653212845af80a4d89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10d1004ae495bd86bb10f48f800ff0f4dd6e2e6d7465016c35ae5df2f7d1f443"
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
