# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a2ffa81824d496e25f582714de62c00a90464a59db0fabafcc8420390f02b5be"
    sha256 cellar: :any,                 arm64_sonoma:  "6260b2b78cc0b0d66587e91c1d3c2389814d55118b6eb07286721dcab12d2326"
    sha256 cellar: :any,                 arm64_ventura: "db96a7c88aaf3167fe7aada061aa604de22eeeb2a4448e313c8faa4fdc86a54a"
    sha256 cellar: :any,                 ventura:       "b516623e38c580d65b0020eb8d7b02cf18f905cb0669d72f7f4eb473278f9b13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9882e940bbecfa3d48c1b082bf8bc802b352f13bf31affb5f803d6438df739a"
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
