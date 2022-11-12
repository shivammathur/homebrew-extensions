# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "6e58131c6f702e9021dfef1bffec49570c1b17cc6bc1f61a479ada3f346551cd"
    sha256 cellar: :any,                 arm64_big_sur:  "d5194304a87ad3c412d7de9c721fbe6cfb268dda14118f09a9765e0ace6908b0"
    sha256 cellar: :any,                 monterey:       "c2f8502fbde14c498ca83a55029ffc6229027e470341d560762470a89445c36f"
    sha256 cellar: :any,                 big_sur:        "8e593a50feec72b6322854d234ec40e8523d1a32dbd89c4e5c20338a9c7d8819"
    sha256 cellar: :any,                 catalina:       "b38cbbbe26b8e9440fff6c27c45d8ff03da763cf09132ff6a12e5f959a681f27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b8cd0a148c427a676e657b17920add75f7f3aa527cef6687f4e45a77e3dc7b65"
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
