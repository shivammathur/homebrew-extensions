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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.16"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e228cc39fa8f9b406ef5822c2068eec5643cfcb443f7e2a0b4b2499c788cb2ff"
    sha256 cellar: :any,                 arm64_sonoma:  "6c66a8f2066fd05ac7d73ee3df77136e60b5e510744d4494a3d35d1ae9f85aaf"
    sha256 cellar: :any,                 arm64_ventura: "2080c823cbe493a339e00265034b7529e1a22fb3fa36125f3c7024a682d56d23"
    sha256 cellar: :any,                 ventura:       "d7f1d0dc343ad1bbb2990b7ce9b151fd9648941fe885ec31622e27a19c93ad65"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "597941170a274ecb8f5081142d2c0cb1b0de790ffe9f26278920924bc9f1d69c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1e8affe903cd9f6ba37c839c2c1197c5e94bcbc67c7d89ec68f18fc5b1da303"
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
