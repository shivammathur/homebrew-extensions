# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.13.0.tgz"
  sha256 "22865b61d264c90c9eaa85d94f2f5f57e564140cad87c8c2601fa33f80efe0bb"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ae1755d1fe47d6e140697bb4ba9e6f4425ac973f1e266917bb36fe64660eb25f"
    sha256 cellar: :any,                 big_sur:       "8cd1cdb0afdd621e04ea9e8550d7e2cb972fdb1091380a6267d24c784c322249"
    sha256 cellar: :any,                 catalina:      "0ef5f7bd3c0445b14e4870f90bfa5965c247225260a3487e650d48e6bb457763"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b5628fc4fc460cb2a63cf58da1b9f18e7aa3c5efa08e7777b0a04c9a1d73b65"
  end

  depends_on "icu4c"
  depends_on "openssl@1.1"
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
