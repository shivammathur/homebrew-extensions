# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.13.0.tgz"
  sha256 "22865b61d264c90c9eaa85d94f2f5f57e564140cad87c8c2601fa33f80efe0bb"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8f7ec93a6f1566dc5821a5b88f7cee8566dfd0496d9e58245846dd81d41fc8b2"
    sha256 cellar: :any,                 big_sur:       "b301cff65c33669393b0e727132bbadd431837f395f3aafaf9b341d24cf8fec6"
    sha256 cellar: :any,                 catalina:      "2194d801b681f1533c6f7aba0fce3b9051ae1073bd377cb18c37a46160b3f2b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7547169c23fd021e27f0264e313e6d25624b76cba330ab88ab9fa2edf1b298dd"
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
