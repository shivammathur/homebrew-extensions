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

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "b98610659c33389c49f6daef6e9ec9bfd6be2e36795343f4abfa8b0af7014a69"
    sha256 cellar: :any,                 arm64_sonoma:  "7b55ca7c4c7103dfccdf22dddbe1eaa7fc4d4ea959c769ced0ec83c923ed8f53"
    sha256 cellar: :any,                 arm64_ventura: "e4e1a442b82a40030b63642ab3ed0a348d7dfcc1d155ed8881138ca94b1e0e35"
    sha256 cellar: :any,                 sonoma:        "1398585a0db038d120d67028762dc61aa1ec9048008a4541cddd2dfbc483b557"
    sha256 cellar: :any,                 ventura:       "d089e10e435dc07594a278ba182ce5fdc147fd5c7e5533cd357ea32baa4fbc03"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1719e3c2e6536c716004f36c4d1a0d83a057fcbb6309ffda507adba3678164eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d4097aee8a2fa1f122552509113d0f677e9275685df8c55169c884947474d14"
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
