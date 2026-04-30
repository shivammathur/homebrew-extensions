# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "2f57e48ffad4bf360e80dfd0a1c269665cc7dbb302971a3c47e66290fd82ecea"
    sha256 cellar: :any,                 arm64_sequoia: "18073177f92f439b0d5f3b02f8b2f403850c4792a827362f6e3bb36dca7e2a85"
    sha256 cellar: :any,                 arm64_sonoma:  "baa6f3bdf00bd4478e26644d80613dd15c8c15128a2aa8f8c246bf52bf0a2b18"
    sha256 cellar: :any,                 sonoma:        "638ed0642fe52e546438df3ec1040601eaabbc30352985d4c11eb3395a41d5eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "006430a1297dd8f38c7542902832bedff2f01d4ede2db5ad64cd419b3fea4873"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e286a06f376ecb0c29a01778531611e150f78478788dd48cfefb35c043538dd5"
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
