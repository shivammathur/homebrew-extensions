# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4c8adbb1a1770895d27fd65df3a6ff9eb67676a7ce46e1bb3ff587b4556ed0b6"
    sha256 cellar: :any,                 arm64_big_sur:  "5e48bcfcaa80c835ce00d2c48cda1def3342ec4469bb57a5c6f23d170bf11542"
    sha256 cellar: :any,                 monterey:       "93c9dededb0b972299c2088e4083c468908b108658dd40a72616534d59cc39d2"
    sha256 cellar: :any,                 big_sur:        "e0be97aef96d269457ce5aa6161495376b4f9bb6e196d2b44d174efc2e064dbb"
    sha256 cellar: :any,                 catalina:       "a8035da971eea8e483e52f24c7c8301fb5a4fd6ece2bbb65e2c461c82a5ce874"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e023bdba0e9f02d19c57f1dceb3e8defc5b27dc9b47edb388bd1f785ad2a63a5"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
