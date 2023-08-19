# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT83 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1ea044388d221e81d07516a3bc37da4564cafe60820953aa69ab9269c135c78f"
    sha256 cellar: :any,                 arm64_big_sur:  "8aab157b71976646a0cb158232ea82378bf60da0f11985a6ede1754c5a1633b8"
    sha256 cellar: :any,                 ventura:        "e19dc4c4808bb561445f2e786f3ff7cd29079e0e0eea834ecd6891de52b75dd7"
    sha256 cellar: :any,                 monterey:       "8f7c1a1c1dbf5edc1499da63d7f0ce6a3b1828212d394868adb51a49e9edcc5a"
    sha256 cellar: :any,                 big_sur:        "0131db9c9bb31c7dfadd48e48155fe6749488c2240bdea154bc02d4b7e74a0f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b8e92fc900951a818618278451146abc4508c242190bbc3ca8b442b6e7dcf245"
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
