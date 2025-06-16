# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-2.1.1.tgz"
  sha256 "bea8eb86be7e301b1cd3935ee3ccfa052e410a7cfa404ae5ab4b11e4c99b8899"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v2.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ce0fac0b2d248b234a425ebece0588fa5c26481b98eff7fb83874f178b0a6160"
    sha256 cellar: :any,                 arm64_sonoma:  "62d6c61b400f66242eb028b2554d8422b1ea37d194dc4bc389f0f6872dc3d99d"
    sha256 cellar: :any,                 arm64_ventura: "dfb6138a10c62e3725e06bface9f6537fddaa0e2ed988ba912b37ea55f0b969c"
    sha256 cellar: :any,                 ventura:       "9d510f624b0c3da93023a197221a4b9e4a2924f87cd94af643808487ffbea392"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f09c7f021ccd3ccae0f60493c6373d29ab22c131455a777d67733f96cf944434"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34b009cf742ecc4225f9587ea3035b9db63a1fd4d9e7792f9e0f911a79d2d7b9"
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
