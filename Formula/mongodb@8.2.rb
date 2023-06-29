# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "752d89e4472a19248d9957491fe68644cd6b9b4ba1f77ce88c013434b518c424"
    sha256 cellar: :any,                 arm64_big_sur:  "2dec89e2426f7c6b6835666f49d00438d0e47c7698e7f9cfc2b437a90d5dc42c"
    sha256 cellar: :any,                 ventura:        "0baa114ef8f4e3a52ed7aa5c359355fe3a14ed60f6bd8a059de62873c443e9f6"
    sha256 cellar: :any,                 monterey:       "9575aaa800aa184dca41ba486df4ec4e78c19b93ade0684929d28e46b7efe8a8"
    sha256 cellar: :any,                 big_sur:        "140c775d1939fe23ad5e77e07a479ea6dbb36004090412230fa2a580eaa6531a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca8e8ae23ca260d6b4649a4cd50ed85cd19cf68763e2319e606d534562afed1b"
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
