# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT70 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.9.2.tgz"
  sha256 "95e832c5d48ae6e947bdc79f35a9f8f0bbd518f4aa00f1cef6c9eafbae02187d"
  revision 2
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "526bb0b98700b79d9fb146f17134a0e2465cae9287ac07dcc4d86136a2e566f6"
    sha256 cellar: :any,                 arm64_sonoma:   "f845c953406e470ff05ab5964c61beb4e06730572a113d95af17cfc9215dae71"
    sha256 cellar: :any,                 arm64_ventura:  "69998236ba591a141e02cdecf8ccdef519007ecad97c7e7c57f1cd38e472f635"
    sha256 cellar: :any,                 arm64_monterey: "7809f327337639f1488ab34938594ac5c4951de18392a3a257ea10a827bdb577"
    sha256 cellar: :any,                 ventura:        "f2efb02e4bf0b992c7039086d69bec7d45d93bf71f56c1d62a9dfa85002045a3"
    sha256 cellar: :any,                 monterey:       "208187a149eb5d6f955116f4bcdc0ba01c377a7919c505b984f466c035994059"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cfc6bd62e9c52abb93d9b3446d5a74f41920875717617512b3e2c71fbf3ed9f0"
  end

  depends_on "icu4c"
  depends_on "openssl@3"
  depends_on "snappy"
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
