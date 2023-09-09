# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c852cdf3f35b38e6d99eb2e5664c3a51f16adf048a3ee37e8979b8277133de9d"
    sha256 cellar: :any,                 arm64_big_sur:  "1c87e9b3fead09850f2c8b6a21508d09cba6473caa30d3b00a93aac60ad75b49"
    sha256 cellar: :any,                 ventura:        "d55b3786abbe685121747cad1acfbeaaa0e02101784678848376abc4f9284d2f"
    sha256 cellar: :any,                 monterey:       "27da4ad5c560a69c46bfd7684fac723f94a5f515ad600049610caeb7e2936b98"
    sha256 cellar: :any,                 big_sur:        "9a15c6556a6b22f3074098052af8691466408fc7aac772547bfcaaf6363e3fec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f4d585d67a7a3c4dfe0353f734675e811b58bd22c2fcab40349f9fe5072dd9d0"
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
