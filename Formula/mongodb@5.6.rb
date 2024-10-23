# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT56 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "4fe7613e6ad6e8b167b6d9feaf57f799159e896c50a5b1a6464f7409f10b4d18"
    sha256 cellar: :any,                 arm64_sonoma:  "394d6606620c6a0d378192c4b6ee35f72352c104265e61e9cc1dcb3dfc591f5c"
    sha256 cellar: :any,                 arm64_ventura: "dfc9a63a05659dcfafef994562c0e5e7c41c320be2953cc1c43825162de4336c"
    sha256 cellar: :any,                 ventura:       "8d648ea6288667e4a53d0e10be1b4a322eb67d36345a944606ea79750f073235"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d96368c4d3692a6bc50a6d1dd4eda400076b60a03c685679578856283784011"
  end

  depends_on "icu4c@75"
  depends_on "openssl@3"
  depends_on "snappy"

  uses_from_macos "zlib"

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
