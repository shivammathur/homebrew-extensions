# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.0.0.tgz"
  sha256 "6a53987a5e75fc65d032ac93cc8d4522a5cd06e068828e6b6e12612597fc88df"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "54612c92066edd2c0679c47a56a90b4726f8a0a2fbdef79de008e6645e7ed734"
    sha256 cellar: :any,                 arm64_sonoma:  "aff5f1d659c81b6d1a1e36b5608ed04ddd05151ad62354c7e9522f325839d17c"
    sha256 cellar: :any,                 arm64_ventura: "28a8e792fd001fd2991d39bfb7cefb825e85526a70e00016ad44cc12c66d5b10"
    sha256 cellar: :any,                 ventura:       "00398ec19eafe3d2adf5d628c13e6fe5026a3f6072d471fdb51d2aaf88e53053"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6ce0fe163caed5b27a584483d74b9ed3dab076000cd08df2e64342dead0dbdb"
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
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
