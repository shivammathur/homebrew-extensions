# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.15.0.tgz"
  sha256 "eeb6268d34bd0b4a3dcc60dde4e484f5cf4fa2439ca3d9f024c0000e99ee7240"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "eec84faeaf0868697bc2eecacc321bdce3bd28343cf73fe3f7ef3b627273bbef"
    sha256 cellar: :any,                 arm64_big_sur:  "2b2c2dcfb20f2090ff43631a45a3fb71b531a97ac47f35f749706d3d68b6a58d"
    sha256 cellar: :any,                 monterey:       "cbe878da9b7995e0cf9083d5d1727b25af63d0113ee7df84530fc74840f08d0f"
    sha256 cellar: :any,                 big_sur:        "f4d78e55ebd3a95fdf4b8c0dce2a7d9564baddbd45fd89111d298ee716be7ad4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b99d65380484a7c77a5785c508008e0b7184605698edaf79ab8015b7423a9476"
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
