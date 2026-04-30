# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.3.1.tgz"
  sha256 "2738972432d36c370fde3c76c208c31bd5a7a0afc4a7705874f92f322f3d2786"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "488e9db0da10e62bc893b4765a4cfe4ab6768b40ec017a6eb7e25b2ea71c1f18"
    sha256 cellar: :any,                 arm64_sequoia: "63a61d110f8e46d9271e20d6f21c622170629cd69b66b2b1ba96797308eaf2cf"
    sha256 cellar: :any,                 arm64_sonoma:  "771e30ace40e48ba1c3c9328bc4d712654535e2bb7e9ef3c406fac703399801e"
    sha256 cellar: :any,                 sonoma:        "7a0b4fc702e6f7841143d5d3bfbececafc7d5eaa0de8f87d5b61cb943bcb0134"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a7d0895cee6226621f7a3216f69315fe83f1da438e4aac1f5669eb72b726976c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6008a87db9457e65bb5004d0635536828a3200791987a2333938222fce47275f"
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
