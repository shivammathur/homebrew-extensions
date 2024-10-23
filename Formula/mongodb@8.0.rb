# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.20.0.tgz"
  sha256 "01e87973fe7e54aac52054ec4a99cdd439ed5c01f7e5b8ea0a57031850d8e75a"
  head "https://github.com/mongodb/mongo-php-driver.git", branch: "v1.20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "3008d518ec97b6781060d82d7b40c15d44f6d1b302c176c43dd0d7a1c1839f31"
    sha256 cellar: :any,                 arm64_sonoma:  "65cd2508a0433db7c773936f9cf20857e2e2ca09bc9277db91aeb2e8cce56c6a"
    sha256 cellar: :any,                 arm64_ventura: "5a17f7cafe5000bd58e52fba8c64e6a1069dc2827968260116ac2c56f0719b4c"
    sha256 cellar: :any,                 ventura:       "7eebd5d4bd242bb8476e1f39d0bbc0b46b02bfcf19166ac9419a9a568a13ab50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2212403761a36ef4a6cae48c13fc4ac0e05833435560f83c7a6fd7697c081ca"
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
