# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT80 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.17.2.tgz"
  sha256 "84081b780d48af884d47f0339800c3666c664c66f0035c66d43a34a10fb67376"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8644bfaa78025ac122f64fca1b1bb6df508b6e6e34fcf30b7b87021ad140721f"
    sha256 cellar: :any,                 arm64_ventura:  "fb51d1184bb458b35edc0b80e2efc3ba93dc70e2bb55be4df4016e2b0efd7865"
    sha256 cellar: :any,                 arm64_monterey: "d7107aa2ef562dfa8ee08dbfb179f18276450dcd1747f1446d46adbcb778d957"
    sha256 cellar: :any,                 ventura:        "6c9ea335af41da35a39ff6b94914ec4d00493dcf84c49d63806da0c7081247cb"
    sha256 cellar: :any,                 monterey:       "1971bb0fa79c6b6548ccd371217fd1ab3ab76073335a0dea420a20da3cc81300"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "551b9214c942040db2d0ab65a3dd696a2d55d3bcae191aad23b12ad517ed2bde"
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
