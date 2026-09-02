# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.5.0.tgz"
  sha256 "532b8408978a3b7a0aa4abdd7b33699ccbf94c312e7fce38da408b787006c08f"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b09514d7339225506096c71c7c847163167273f55b4b143c313c47bd87c8013f"
    sha256 cellar: :any, arm64_sequoia: "7835b0efd68d4137ddc29aaf878354e4971a782fcde6512dc281c0aed095fbbe"
    sha256 cellar: :any, arm64_sonoma:  "3435450388dde0ff399ecbb6104d1bef7922ae65f94c9ee0461db9185b6bc59b"
    sha256 cellar: :any, sonoma:        "492d056ae278b70225775ca92d0449cad04a79ba14e33dccf5562676f073504d"
    sha256 cellar: :any, arm64_linux:   "d7032961aa2c5a7ef799ecce765a6754051b463397de15d8d4d037eb83feec05"
    sha256 cellar: :any, x86_64_linux:  "500c465040e64f06aea34ca50e228d6b08683574818c58aa1b8880ae598e96de"
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
