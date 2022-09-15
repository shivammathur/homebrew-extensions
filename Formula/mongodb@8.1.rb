# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f04de6ebfd7636e8bf18fc88a2ecda5d8a735567f3aa9839146bca0ea0c2b3f0"
    sha256 cellar: :any,                 arm64_big_sur:  "c7cdcb8f60935bb39873219d9ae908de96bc5808d1838dc7c9c74c3da90cacec"
    sha256 cellar: :any,                 monterey:       "4fba37883da9b5d5cc8a09304651e00fb784b429172e25ec85c1dfef9ff26454"
    sha256 cellar: :any,                 big_sur:        "62b81b0684b8aea8dc71c0f6492efbde24598b725afaa108a03fc33a3f7e6ee9"
    sha256 cellar: :any,                 catalina:       "70064d15e3329eee76d7e8da509916789c43e3466ec9b744ac5f0afc6292e2bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ac73b5aa0d7fa253f706d93c581ca0da1bbc88686f5139a915a506dca8eae6c4"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
  depends_on "snappy"
  depends_on "zlib"
  depends_on "zstd"

  def install
    Dir.chdir "mongodb-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mongodb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
