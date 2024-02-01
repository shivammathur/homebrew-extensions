# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "0fd1794cb8299cfb81a5027b89e97177493bb98ba2b8bbee803330078e273bce"
    sha256 cellar: :any,                 arm64_monterey: "4b0722fec911e696420013b443cc7a5e5a16550fd5a841b4355baba8377a8f77"
    sha256 cellar: :any,                 arm64_big_sur:  "7d569334b47a6ea63a30eefa194faad85194fd35d5e0c2b72f754a397d624356"
    sha256 cellar: :any,                 ventura:        "59e372983ded9432b4a22d9a0261a521c9687c99f6bc982af97cc93edfadecf2"
    sha256 cellar: :any,                 monterey:       "37631ec82a702a002118ce366f0ddd38bfb4bed6924b7ea8fdc47b5559661653"
    sha256 cellar: :any,                 big_sur:        "af2078264d383763e5ec828c835f5d733b47c5c222cd437526f4288b21b658bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0175b0303e2260bbe5b68e2f51e13349879d692871370a2c0b4c5b6fd722e36d"
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
