# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT81 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/mongodb@8.1-1.15.0"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b2a97a0e4186048ea579090bab710c17b64eab1ca2e5edf13cf1ea800b89c27f"
    sha256 cellar: :any,                 arm64_big_sur:  "b19883d227b2cadb0e021acb46d7a45c1528592ba8679d2b645d1c1d103d2544"
    sha256 cellar: :any,                 monterey:       "7f48edb84e37fa79bab8d133ca673ccaa47d88fff6f4ad77d869c47a9868e6d2"
    sha256 cellar: :any,                 big_sur:        "e4b29e5570ef446cb2a46d5e626b3d6cedba3c26cd02962fe45dad22ed0db253"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13c59420de2d041279235c920c8b697c358faa3cbb198cd249cb22d6a474d233"
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
