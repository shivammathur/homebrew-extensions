# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT72 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.9.0.tgz"
  sha256 "0fce417b33879fdae3d50cc1aa5b284ab12662147ea2206fa6e1fadde8b48c58"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "62ec6b420edee0bf1d549683fbd47604a6ecedc719bb97460434eeb6e95b31a0"
    sha256 cellar: :any,                 arm64_ventura:  "8a3cbb4ca93e5a5a945fe59b5bf0780c41185d9fa71b99aef4611e0a5df1efc9"
    sha256 cellar: :any,                 arm64_monterey: "889f7eb4917884593ff015232e8e493a5af60abe5dfa981899668220453c15aa"
    sha256 cellar: :any,                 arm64_big_sur:  "9cd167fc763476a386b8790605d2a2136b293b2fc5a832a5949896534bdcc1cb"
    sha256 cellar: :any,                 sonoma:         "1e964fc018275362b0f8b4b13322ea8809c69e0a5b181b36e63c9c115314987b"
    sha256 cellar: :any,                 ventura:        "76468778b11b1bf21d5f2122990b302efd29dd47054148b358698ed7d3d7ad04"
    sha256 cellar: :any,                 monterey:       "a99b4830211ea17aeea76e1456bc79805455bb5896fab872f2286996bc1ff54f"
    sha256 cellar: :any,                 big_sur:        "3179bd2b50b4e38c6fbc71e013e2b0e231330b7efc934178bf0c8c2b720db23d"
    sha256 cellar: :any,                 catalina:       "a8443e5639e6675b72aff7edf083fdccf3f3fc116e1398774799137f5e50a974"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "243a98f20feac1e05877fb48ea7fb873f677f7353cf60af80ffa87882df93ae0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "012b63bbeaf118e5568e8a37ec20ae726a6f7b2af2ecddc2b41aceee6776c059"
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
