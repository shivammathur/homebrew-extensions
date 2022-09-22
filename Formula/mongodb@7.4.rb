# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mongodb Extension
class MongodbAT74 < AbstractPhpExtension
  init
  desc "Mongodb PHP extension"
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://pecl.php.net/get/mongodb-1.14.1.tgz"
  sha256 "bae2a876fdcc13d6cd0139fb5b2aefd51c9d5c84a6a4fc53bebdbe3f162d835e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8a9f4d1ac6221067f2f7ca33fbfc41e6f937100ef06cce147c067c0a099338fc"
    sha256 cellar: :any,                 arm64_big_sur:  "b3bec8c2e65d3d82e3aa124f1fc289b0445df2d91fac069331f7791735f432f9"
    sha256 cellar: :any,                 monterey:       "31175181fc947d9db441b487472f90289067b699f94aaa1b961d378b00ce59ff"
    sha256 cellar: :any,                 big_sur:        "5513b873691d717ccab59b64ba6e6246c896de931e079180977b1dfa94576fce"
    sha256 cellar: :any,                 catalina:       "08b87b24005279d621aaeab8150aaf9f7dbf9606945e42359a270721cf85dad2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a3bb44c07a3c2b2f213c47b5feb2f4e43c4fb2a2e8de931072401b4a462c6a9"
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
