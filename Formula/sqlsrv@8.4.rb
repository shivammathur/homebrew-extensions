# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "8e58b9b38f6b43856abe12fc04d0bf7aeba32de1c21107b9cd23a4d3a282ec84"
    sha256 cellar: :any,                 arm64_monterey: "5986bb2feda4ff1346075347abf2b5dc78c0c2e2036a42425d78b52ad9c4070d"
    sha256 cellar: :any,                 arm64_big_sur:  "35b4dc52c2d10765d6bead2d77b80c07a75dbb509d53abba272280fdfa8dfe73"
    sha256 cellar: :any,                 ventura:        "9932a46b368255b340ff6af2a3c8fd874c8eaa63581d3e07441e60824139892d"
    sha256 cellar: :any,                 monterey:       "a3e74c588583a9c613e35697c3c2cb1d5ef52add9520c03ab6caaa3f60be0096"
    sha256 cellar: :any,                 big_sur:        "d0278aff530da10d2cb3d9e7f34574abf6f2986c8fa7325b86d1290c8b6fb082"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6193d81378510d8138be9c3b343aa24389a64507d9c66288b434704a6cb2c7dd"
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
