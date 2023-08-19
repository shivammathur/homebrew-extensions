# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "1435c1e51682f20c165c6425216e3d7fa1b8b258901465a4bcdf960b72be13c9"
    sha256 cellar: :any,                 arm64_big_sur:  "b8a65d84c46bd13dd301a1de99a306ff2a680869e6a7602da489334dd9c88d64"
    sha256 cellar: :any,                 ventura:        "85626fd7041bdbd87446387fbb0ec6c57bd90e012e2e69ee690a06da9f18767a"
    sha256 cellar: :any,                 monterey:       "adab43bdd2653ea99e2fda2e6d59673bc366b8a6df8d57ec1d28826cc1851b8d"
    sha256 cellar: :any,                 big_sur:        "1db0665f2002c7d3968a70e6175655bfc0e66f66594a2596834339a74bac3588"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "891891d345eadd06cd9eefcb45ae543c85a71b2aa307f9215dd2c00ed7af10df"
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
