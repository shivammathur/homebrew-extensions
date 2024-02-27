# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "a555476dc9c817db6331ddc75b91f3b408c6daac3de9de134c26d818c88fd2f8"
    sha256 cellar: :any,                 arm64_ventura:  "613ce7c108576b0c42c81178ec141724d8850c2788bedb84dbafdb6e3dbbe5e7"
    sha256 cellar: :any,                 arm64_monterey: "47f6db11267fb406f07f5e87db192da1f781eb7a524a1f56ec656e0c445d0c60"
    sha256 cellar: :any,                 ventura:        "0404dac9f6fe4b22d04441677e25800d4f01e461e145b3a4fbb2372b9286c854"
    sha256 cellar: :any,                 monterey:       "7dd8dc23c9cb3f68835239be931291581654bc933eb5f2f7734688067d20d30e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b0262d9a670e9a54a97621a84df6464863372fb39fc4b053389b2b77bd4ae77"
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
