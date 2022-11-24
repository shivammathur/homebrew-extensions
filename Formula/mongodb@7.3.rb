# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT73 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "47f5de1f39507f915a9577723acba36e236388775fc7e66a11d1c1c8a9d40f34"
    sha256 cellar: :any,                 arm64_big_sur:  "bb7ca7cb8dbdf55fee4f4f361598b1c0ba35bf1fc1d1dfeeb91eebc07758bba8"
    sha256 cellar: :any,                 monterey:       "bc325226ac746988f3df534b18d9460eb3b2d2038b7df916ebf88cac53a2b714"
    sha256 cellar: :any,                 big_sur:        "c75190d7cadbe08552b3c24486b640ffbaf361caf8f6276267710ec612965be4"
    sha256 cellar: :any,                 catalina:       "068e4f4e0d31309388a108c3a33baf52e09416a2fda291bfd5c5b21b7d48747d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8a558b7d6583ab26567747cb821a429e1c508a45f10a2307d626ae2ab23e0ad"
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
