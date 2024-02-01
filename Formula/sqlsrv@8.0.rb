# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "7e0d3fbc1628fb3ec3b5b992f6ec0fae458f3236f6e998b57f1f02f4aa81f3a5"
    sha256 cellar: :any,                 arm64_monterey: "0f3531d0ba53aac17a3f3cf1df7c36cc29d0b60ef4c393c9c49cbae198d58146"
    sha256 cellar: :any,                 arm64_big_sur:  "a8e1a2bdb54de64b3fe75bb664cfdf6aa13298d4c0f72cd93c27efa577bdbb39"
    sha256 cellar: :any,                 ventura:        "5d05653dd4efc324e15baec31655ef2d550d632385501076dd15b549a5205faa"
    sha256 cellar: :any,                 monterey:       "fd3c159335d8903bad79b34dfb50d32f2a84db4736cbfff7d0bb6f05ca836bfb"
    sha256 cellar: :any,                 big_sur:        "1cabd41d7c51e348e6c224cb3b399cfd9606277761d1b170c4ed77a5f0dac94c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9e6a9ff359b6a71525a4fd029d3e1bd86eca77b61a5258c61a8e275a99266ba"
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
