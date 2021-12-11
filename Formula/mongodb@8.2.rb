# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT82 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.11.1.tgz"
  sha256 "838a5050de50d51f959026bd8cec7349d8af37058c0fe07295a0bc960a82d7ef"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "31d4a5e85ade033e3e09e5a5bb2cc9e0662bf4a5cc4f12823c3a0f183efd7aa1"
    sha256 cellar: :any,                 big_sur:       "e0e270cc3ec5034a4f1c31c2babe0c8d570ee13a1d6888cd56ca53ac8edb9d31"
    sha256 cellar: :any,                 catalina:      "d7bbbe078aeebcc242bb4ffb4587717bd7f464a0d45c96593b4684b2cb5c4001"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "723c44147181207f8e00827b17f77e3c592b4a7297c76b412e025956df58e07e"
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
