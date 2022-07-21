# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.0.tgz"
  sha256 "55775e69207a7f9c43c62883220f3bc600d3e3f663af50000be70ad3ee51818e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "965d46f38a9484bc8f42dc532407a249bf42d153743be9aaa6040831ddb20661"
    sha256 cellar: :any,                 arm64_big_sur:  "16baa22e9c39a72a5334f2df1939bc75588ced0efbdfae0b0411face06730d56"
    sha256 cellar: :any,                 monterey:       "8bceb347d39d27046768cb73db6ec99d6a9be35e440b3043564156d6773c1a14"
    sha256 cellar: :any,                 big_sur:        "1d2f5b14774324ea7957108f87079706af2db985c98b687c344ac0c3eebbc491"
    sha256 cellar: :any,                 catalina:       "7336491bf22b878eef26b41567b6e5f65d71d51a6ea660c8b661148df6f5debc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "67b85315fcb2ac3f3f75552ef9df536a36c5162871ea8cda428e768c1ef0721a"
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
