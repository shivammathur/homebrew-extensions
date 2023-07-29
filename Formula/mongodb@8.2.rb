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
  revision 1
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5e0a774193d8b83a01eed53a88414dd6316e1f3f2eaf50dd1c8ef5aee3c6e5ff"
    sha256 cellar: :any,                 arm64_big_sur:  "6aa3ee001e4ce12e12210c9eba22cf7604c7202626bfeb08277c6887f96acefb"
    sha256 cellar: :any,                 ventura:        "72a838c48fb08a5b618f14f1bc062d746a0c689f30478251c1fe3a1a837bcfff"
    sha256 cellar: :any,                 monterey:       "e055cc06b6094eef64bcfe495e856651133e4aba83574e3c55cdba0c8e624eca"
    sha256 cellar: :any,                 big_sur:        "ef21264218c3e889caa86537c9e1a2c89f69ed1351862a58d4a031bbc0ff7309"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "462b3887e3cf09fde6860c20912940958329d091a195c075011916f031f9606f"
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
