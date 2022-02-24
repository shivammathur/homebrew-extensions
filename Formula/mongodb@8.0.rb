# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.12.1.tgz"
  sha256 "925d7e6005c6e84bb40a25019c12b0ee4bda625c6449769dce7d5b026983f433"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "9e7e57b71c73e5eab3ee9a18fce425c098897cfe0f916347929acb123afa147c"
    sha256 cellar: :any,                 big_sur:       "5c8c259de08bcc19009e4017bca1a955bcc535d6508020c712a0e95bc671ae96"
    sha256 cellar: :any,                 catalina:      "583f5496d2abfade51d99eacdc2fea7eb6931cbd926b6976152ed94b4d98e5ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a02fa4bc529bbc4546721491857c1a646f927e4fc8b7eed5c8f353da6b56e06d"
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
