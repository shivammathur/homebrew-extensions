# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6f6cd8d3d55eb781d9306db3aeffb1f975317513feb8d910e99ce92c756d0835"
    sha256 cellar: :any,                 arm64_big_sur:  "6434f53116997bafeb62e04dfdabd2c9b1030c275d7e4b9fb61fb967ba5e04d4"
    sha256 cellar: :any,                 ventura:        "9831ceca21bc8ffad1c0d9e8e0b56b0abb9bc5e8a297af91f3862d25daaa9ca9"
    sha256 cellar: :any,                 monterey:       "b7c4fbde5354380e26941dbcb13ba2250b1a3c4c138de42db6e07a867935f5ce"
    sha256 cellar: :any,                 big_sur:        "7f0cad989c89147418f5254fcf7f8899efa1f209be574f523979c232ec04a1b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2dc5a6bbaa94dbbcab3cbe9fe39c5c40d42ff9877662073a962bdd30bc4f82b3"
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
