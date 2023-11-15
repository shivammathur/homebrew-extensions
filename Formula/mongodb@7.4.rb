# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.0.tgz"
  sha256 "5e7db95103d73212ed0edf8887d92184baa5643476045cb899efbcf439847148"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "52a438187013e53052c69e05192829604777d7fff9b40d61fe59268da9c783d4"
    sha256 cellar: :any,                 arm64_monterey: "29d9cdfd9202536e5f9547f18841372f8bba68f68d7e49270cee0237f61ae330"
    sha256 cellar: :any,                 arm64_big_sur:  "264c7d94981bfb041bab0786e23a821109453d124dfe19724f2588aaa6bb1995"
    sha256 cellar: :any,                 ventura:        "f482b1e56c25e569f7a9c539a1e7c46b7de0027261cfeaa32f1e1069a8705a35"
    sha256 cellar: :any,                 monterey:       "e900818765589b1a9307652aa8bde6509815519bcbf79043421049116eda7f0c"
    sha256 cellar: :any,                 big_sur:        "4f57186ca5e8462cd355be5920bc4bb9e9678339bdad24ad5ce3701133f75685"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad8a3bd390374be32299ecbce1ac6421967bfb279c2fe81b24f9bfcd20b69746"
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
