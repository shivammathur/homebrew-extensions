# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.13.0.tgz"
  sha256 "22865b61d264c90c9eaa85d94f2f5f57e564140cad87c8c2601fa33f80efe0bb"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8cce44b7139ea7116b74ddc1cc0da9d9b6463dde0dec310f60204b8c22d376e0"
    sha256 cellar: :any,                 big_sur:       "6f978d21ea1bcf4d82a8daa708200698987eb16887d53eab0d663368c3e775a2"
    sha256 cellar: :any,                 catalina:      "e910098fd0e51c3dfd32099428ee723dda9f01e605a64922028f400b57d24c5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b40a251e1e419f2542ddc23be508c5bebadfbaedb0b9772b2a151126187856d"
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
