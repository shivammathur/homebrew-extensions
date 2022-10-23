# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.2.tgz"
  sha256 "6f7ca35b997cc9d75431765e11f675bddb634aaa9b63b4087181fa99b9f2aaaa"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "91652ba6617f3eaa8524cdb8a6cecbf041911963adaaa1334f86f2d99f07c6bf"
    sha256 cellar: :any,                 arm64_big_sur:  "d3635240774d2b35af7ee3b89116849d31224d31207dd72d860d62c71e744431"
    sha256 cellar: :any,                 monterey:       "55afd507fcce7ed8ed7c07ddc4585683951d4a17b4d2d16cfabec03663cd4677"
    sha256 cellar: :any,                 big_sur:        "ff1e2eeddb800ac1c64facd3822dce14d6a23768a1117a88088b534a13dc6980"
    sha256 cellar: :any,                 catalina:       "39f145a018fb53c831b149c505b91f9ed6d1192758f5d6448d6ead1da51111bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82efd3c0c789a85738eb206400c6157aa90316a781a180241eb494a49cf65fa0"
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
