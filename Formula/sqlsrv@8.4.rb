# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5986bb2feda4ff1346075347abf2b5dc78c0c2e2036a42425d78b52ad9c4070d"
    sha256 cellar: :any,                 arm64_big_sur:  "d6e68ebd1a8328e9cc2ba3b81969106b6a03534f9deb1ccac71fdaecbfb448f1"
    sha256 cellar: :any,                 ventura:        "9932a46b368255b340ff6af2a3c8fd874c8eaa63581d3e07441e60824139892d"
    sha256 cellar: :any,                 monterey:       "a3e74c588583a9c613e35697c3c2cb1d5ef52add9520c03ab6caaa3f60be0096"
    sha256 cellar: :any,                 big_sur:        "b7ab0f336cc709cce07cf3ad702198eadab9e4671f7be759b80a82edbbb417b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3314efd6fe4a47af9a6ef1665c2688f6b4e3557877b841f3726b9cd988d37556"
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
