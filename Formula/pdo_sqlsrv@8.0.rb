# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.10.1.tgz"
  sha256 "c7854196a236bc83508a346f8c6ef1df999bc21eebbd838bdb0513215e0628ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b7f5cef48f1776071fb9b6a31ba1bf37e6cd3c2acc8806b8e4c32c82d333ced6"
    sha256 cellar: :any,                 arm64_big_sur:  "768a6873f0bc59a44398d9c9b5fbaebecf15773634b1781ad5d7f3100d52f767"
    sha256 cellar: :any,                 monterey:       "46fa5713224f5f7a3dbdaab1a586c67882e8473288821baa9706d1c0b706c81a"
    sha256 cellar: :any,                 big_sur:        "6e3d9a3c68c7821b93bc585f3f4f30b06911abd2b0f45ee43dfdce6d3692dfa7"
    sha256 cellar: :any,                 catalina:       "bafae3d011ac69b59e98c6a988e7956a0ec16dc7504b5244474b1b0820e523f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b8cd2dcec10fda74c0655015c2a3769e162155a2ae18687f23e0047b934cd37"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
