# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.1.tgz"
  sha256 "2c5b7c7ccf6ca26d25af8487f4028390f0a7dc49efb2eb360a65840e1d6f566e"
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9e241c53728a1adabe3923dfaed5138ade47a6fb88986dd8e97eabce78d3fa4e"
    sha256 cellar: :any,                 arm64_big_sur:  "de19249cbf4b720cafa7a362b1954b16440393a3726db273520f7b0afc440553"
    sha256 cellar: :any,                 ventura:        "8b267cb145a0fbae096304a6d9f886246042b0a11ae481f7d554e8ef72910798"
    sha256 cellar: :any,                 monterey:       "9cb3dcad33ce3eea135a9d75b7fffdcca330f6bd9423a5c0739f0b88f4949fa4"
    sha256 cellar: :any,                 big_sur:        "f9762aebd8ce0a1ded8a88443745d77865e0d9060b5b0fe72b690a5de33175da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d6e6b0d572a13f9157f3acf65b27719b9374c6fd6747914cfdfe579908e2bdb1"
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
