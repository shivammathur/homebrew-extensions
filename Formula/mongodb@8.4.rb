# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "432f369e580eed9f76abd636b9d57163946b1f6fb02015d79e88547f241fa109"
    sha256 cellar: :any,                 arm64_sequoia: "f67bf2428fc758a3fff4927cff013df735c5214282ed0bfb9fc6799ffefab190"
    sha256 cellar: :any,                 arm64_sonoma:  "51c5f7c0351005bd920ad7a4c3109b7e1d3b34511818f7d48afda36e038f8ce9"
    sha256 cellar: :any,                 sonoma:        "c94602894e1c8b210982a8c6e2d5232471e8260d5e97575bbef0f44acdf4f05a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "23f018ac00e59d530dcd62ebb1ed224de74cd901a9aa10b3fbcbfa9eb4b59152"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84b9726891079f36195751e2f5e67bee74a5ad81a8d6e36a83853a7563354fda"
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
