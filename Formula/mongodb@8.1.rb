# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "6755b481e9a5503dcb831cf9c61ff3ca81b22919628858b1ba35a01eb0f6759b"
    sha256 cellar: :any,                 arm64_sonoma:  "83332dc6e8107bd6d0d61a6c740635f64ae0298edea27be74f1aba0e2c38034e"
    sha256 cellar: :any,                 arm64_ventura: "d376d62990baa00c2b8c44ebb4759057f873e030b0d9078d748afe0884f483b4"
    sha256 cellar: :any,                 ventura:       "9354904a714937f559c2704c82267e66a7009a3a95107e53e672aa32a5611671"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19f7088c46292c68b30d91d9b602ea12573e3c6b2a8bb700857a8c625d617207"
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
