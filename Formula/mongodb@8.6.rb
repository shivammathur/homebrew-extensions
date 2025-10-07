# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT86 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.3.tgz"
  sha256 "6ef901d143a739c0769fad5b1bcd92646baa094d532e43738b48a13039ab067c"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "57b418257a21edb8cfc5c82c8e36d1e9179b2c1dddd5b1fd5481f617efae7cd4"
    sha256 cellar: :any,                 arm64_sequoia: "585ccb42c72ed4b19ba4d5eddc48975a2a99b81b15ee965d09df5a78b5341378"
    sha256 cellar: :any,                 arm64_sonoma:  "4fd3f8cbd8dae0279319140c295f99529e552b0b2eff2d02082fd6f097b974f2"
    sha256 cellar: :any,                 sonoma:        "85c780f92ccfe7c5a5f606fb63be8cb53909347529b60b4df1100853b3577287"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "38591428dd52cf0d73db5e6ade343d6e129de848bed05b268091bf24ee0b71a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "226c5a5a10765cad76ba6419125b655ba19c2188d4a7833663f94992d56b66c3"
  end

  depends_on "cyrus-sasl"
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
    inreplace "src/MongoDB/ServerApi.c", "ZVAL_IS_NULL", "Z_ISNULL_P"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
