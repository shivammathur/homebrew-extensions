# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.1.tgz"
  sha256 "614e57594918feb621f525e6516d59ce09b78f5172355ba8afb6c2207c1ce900"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4984a4986fc2a781e791bb9781ee56f84879c5bccfa24907a2ffc69b231c7ab7"
    sha256 cellar: :any,                 arm64_sonoma:  "7fe99815172265056dbbbf5edbe278039b633bd02456893f4135fc258d255d47"
    sha256 cellar: :any,                 arm64_ventura: "cc700891c0be16adf75cad57887d59794e2016e8ea72ffc696330c1a77916370"
    sha256 cellar: :any,                 ventura:       "d10b515ad3d472a523435def645d23a024ade130b1533321948e4dbab3af4d1a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b93c1b6a82accc076478a45f2d51271059f9fa808a19f4f7224b7f1fa7d7618"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23e106cf09940ed63642cb6c5fc470e25ba4154443d896fdf0ed1883d3c4d499"
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
