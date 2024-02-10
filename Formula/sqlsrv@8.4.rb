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
    sha256 cellar: :any,                 arm64_sonoma:   "06aaf93de2a705ee3e7f90b98d38257f0c681b4ef4cf697656a5b4f125a37bf8"
    sha256 cellar: :any,                 arm64_ventura:  "8eca33ac43bdc17e4254826fa3f86b2c8adecbf02b61d5061f8471e3a53f6e60"
    sha256 cellar: :any,                 arm64_monterey: "67b8674e3dc3f9b18821d1b5bccae7fe6a0e7283cc7569e45e4e56eeac4b7e4c"
    sha256 cellar: :any,                 ventura:        "e82df5c825bb73082bf621f3134a0bcb64dca73b783a446b753fcd2b7c1ac422"
    sha256 cellar: :any,                 monterey:       "3dd37a71d61f7e81219f3a273e6cec5d156cf980d3e254cdc40a4d7c1c228a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "22e7223ee1edbe6e7d57efe2966d15bece0ce0ac35a5820bdb3ffcd015dc0e5e"
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
