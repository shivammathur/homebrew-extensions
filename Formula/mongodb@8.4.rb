# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT84 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9b2c682474c1057be77f9c6e9030c934bd23006774f75f6cff02a9c0f800ac14"
    sha256 cellar: :any,                 arm64_sonoma:  "dff0c0bdb5413a4aed131022631e2fbbe7dce1bf6dd4b646b0a7a83a940b2ffc"
    sha256 cellar: :any,                 arm64_ventura: "6a06cca4cfc54a188d2871efe1a11e1fe1500343a0ef62989b2b5eff309b3394"
    sha256 cellar: :any,                 ventura:       "a5d32e8af99d4904d1d6c8a7629d533456dc89140e89ad5bc5268fd7269d288d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d7bde54225f6c8a522356672076229773b393e25f62bfee60d1cfd63143068e"
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
