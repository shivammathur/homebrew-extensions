# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class Mongodb1AT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "7d6a2079cff2f89d0c8fc211f12af00d8162af5dbebfa19331a73989ac78eea9"
    sha256 cellar: :any,                 arm64_sequoia: "ddb88b3f72c263220113cd89d3f9bdfdffdca886a6922628163108a5772bb62f"
    sha256 cellar: :any,                 arm64_sonoma:  "5d258eb2c3390ad87d484b2f3361f744488862c8feff12de3671f9498a4871aa"
    sha256 cellar: :any,                 sonoma:        "ba8fad4ac6f0a9c91e9cb896503df8ccc3cc531bbef5727c33fafb8572117e6c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7b70a95c910df78f926d29fb9bbd1fd475d6a8c3b65d9959ce0ca828e2ab6017"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eda8c9d8b3c69b8fd3ae502f29e2fe5077e2a01220bc07bee60cfca7929e458e"
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
