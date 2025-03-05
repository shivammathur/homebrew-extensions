# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.21.0.tgz"
  sha256 "336506cfd52a878c29bf7e9fb99ff70054ab5efef19ab063c2d28e3889fdb557"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/mongodb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "60f67a2c92f215ba02a99cf0a7e636e3550453154a5c277361c10e57b65716bf"
    sha256 cellar: :any,                 arm64_sonoma:  "30c3519d6e6951740b8b00f39dbfcfb7b4b4256e1f80db00657cf13049b746f4"
    sha256 cellar: :any,                 arm64_ventura: "0997f83a613cfba5312ed792971c1c64471514e4e6b20ad705935e945dc6a528"
    sha256 cellar: :any,                 ventura:       "6c7186455cd5f1d96e669487ecb43eaaefe3ad80ef2b5ad1085abeebd1ef3408"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "884f4fa36cee5000afce236f9a2fd7427fca8e3858b96099fb83c3c88eeaa670"
  end

  depends_on "icu4c@76"
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
