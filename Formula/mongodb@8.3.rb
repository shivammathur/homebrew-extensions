# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6c3cf8e870170729a9b52a71853ff29f6b02406c0b5a3c2c2b1f5d62ac8d8b07"
    sha256 cellar: :any,                 arm64_ventura:  "fb25bd79b27be804f1362064a83758657ae5d62fab3f5948a88caab559ede8d9"
    sha256 cellar: :any,                 arm64_monterey: "6540877776d6e5c024b9889542a6b0bd5d66a10038d58d69184b591cf7205d4f"
    sha256 cellar: :any,                 ventura:        "b31c9711cadbf78d43ace08b6d955dae6340a553b2fdd4506d8e5258d61f3f0c"
    sha256 cellar: :any,                 monterey:       "b16cc397880eb6b152a54f5fb8309056b1b53738cba433c229bbcd0a3e2dde41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2192246419c0895ba79f3e6f554dcc3557e8632f07d4a2f3475dacad3f416cf9"
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
