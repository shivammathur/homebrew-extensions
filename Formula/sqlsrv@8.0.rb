# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b29d64d911c7cf14dc804ae8703d56b392a73c5d10e7ff8da77ed7572787f1db"
    sha256 cellar: :any,                 arm64_big_sur:  "9a85aae5aaa3167f00718f23286c824a2cd84a1633e62c251dad4876894d4772"
    sha256 cellar: :any,                 ventura:        "35ccc30bae6bafa2f661c00cf512e20d1e5cb9b4ef77a4ae61dfdf71d73599ad"
    sha256 cellar: :any,                 monterey:       "735e24bbd33837f175202e71769e703b36fd9d1ebfb04b2b0a62d0e5e0a3054a"
    sha256 cellar: :any,                 big_sur:        "b6500633577b9eb8ab4fbe5cb1522b266b4c3436d31cd58b0a86138780e82a13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1d915b3f079328a0f5cd3dc8564a3dc15a98aa5c65c972b3a4ff094fb89f0fa2"
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
