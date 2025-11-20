# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT72 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "96f174d2dd9c0ca927e14f53856ef22b7d7c07a50b1382928596f9c617c3abd5"
    sha256 cellar: :any,                 arm64_sequoia: "6a5d5ed53f84e3bef8255f5b6baf50eabe5fc53204b07f588cf0a78bceb4bab2"
    sha256 cellar: :any,                 arm64_sonoma:  "0975e28241c5720749e0389ab09387e65f41a2f81cc65803c82bb8b291649e48"
    sha256 cellar: :any,                 sonoma:        "460bc33b52eaa583fa55b3ea7bc9281150ef2214b47f5110b5f1783c67725a64"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "142c642b11da43ce3c91e9b383192c80ecf5cf939512b522efb019d44b2f157e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d61b91452b067c2d1d99d23a6d92bbacea1f1b939c84db7a9083d169e9b8051"
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
