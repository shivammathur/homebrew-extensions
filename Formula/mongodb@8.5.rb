# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT85 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.x"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3cb9e3c8701763778340afd41d4be15f3ade35748c7812599e1b749e4975ee91"
    sha256 cellar: :any,                 arm64_sonoma:  "70d22d81ff1d64270008824df14356a26224aa1b3d6e2270372111346a21cdfb"
    sha256 cellar: :any,                 arm64_ventura: "aa0dcbd44b895b3e8c21102874fc45e025a340e190cecd8c34fc43dfb36fee1a"
    sha256 cellar: :any,                 ventura:       "ab45a85c44cafad253f67540796ad16564acb92560e42dbaaaa8c0afa0fa096d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5fdf23ed52d55fa6aa7035d81017a6b8bebe3cb27ef24736f161f7858db82e4"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
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
