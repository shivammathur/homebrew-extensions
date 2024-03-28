# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.18.0.tgz"
  sha256 "6c36290441d72f2b0520bd8ab1d50c80de4c42240db6ff502e3db04c29bd8b54"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "fe8a75888cb23a98e4cda20c9ec1f1e0333eb564ca7f9c230293545624e030c2"
    sha256 cellar: :any,                 arm64_ventura:  "735f48c4c44229ff19cb20e014c0f68018a8b9c74b9e40b91eda56df1d6e447a"
    sha256 cellar: :any,                 arm64_monterey: "d3ae2e976bf203f80ee908b49302e387576293f9da5be3dc91f07712de1e68e7"
    sha256 cellar: :any,                 ventura:        "662531ec1290e1e4060d0af9c1ee160b5103f36db68baaf03cb13bf26cdb2f75"
    sha256 cellar: :any,                 monterey:       "766a5399f9cf0ac71a1b7249335cd0a676c0d820754ba2a9de0e93f03b81bcef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b058b3afe561dbe869e3ef6c2710eca9a2576d6a12e2112970668e874f6c4c52"
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
