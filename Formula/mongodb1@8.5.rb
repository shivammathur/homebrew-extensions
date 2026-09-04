# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.9.tgz"
  sha256 "05045ef555d042991c6991d4439b85ebcaee5698f3733516f656508131d6e6c3"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.21"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1aee88998d1dc001821c8f743a685b8b090b0226575d5d494c215aeb85ee27df"
    sha256 cellar: :any, arm64_sequoia: "54de99d94976a11a4ac96d3fa36c0c1774b9403a826283a6051c4d898847e916"
    sha256 cellar: :any, arm64_sonoma:  "3cb56eaaa558314f0e05cb1b85493235851da705a36e8e02380b97980e1823de"
    sha256 cellar: :any, arm64_linux:   "3444950ba4bdc97829fd2aafbd1c92d359aec6e38baef87445ed14f0f53b3ad3"
    sha256 cellar: :any, x86_64_linux:  "a59d3e1e1a8aebbe4bed0235c608e30fe6b0b3932a482879882cbf4922a7b27f"
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
    inreplace "src/contrib/php_array_api.h", "IS_INTERNED", "ZSTR_IS_INTERNED"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file
    add_include_files
  end
end
