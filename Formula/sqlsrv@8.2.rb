# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "26e5f0d1863a6e25b72f1dd6db728f753c440ffa8139c5706d878eac36d21460"
    sha256 cellar: :any,                 arm64_monterey: "28c1bf80ed0be142d4216164a969b4d425f45ccfd7709300aa30e323d53436da"
    sha256 cellar: :any,                 arm64_big_sur:  "ac8122137fa8d0c50349181718770187a7d7e1003700c520926e0e531e1e0f2a"
    sha256 cellar: :any,                 ventura:        "3f3652c5881ef85c0a6038f34d6a201b2152b5a489333bdde0665fbaf348f12a"
    sha256 cellar: :any,                 monterey:       "2ecf556e89b26281ba76c1740e495df419a481f170ea1946adbe75a53972236f"
    sha256 cellar: :any,                 big_sur:        "15932b3630954d8d6b83a0b787182ce4749ba307da814c08a641cf0e41ad5b03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "191efddc8b729b4e0e4798668e7b8baf98fae96d625a260093b6821452429a08"
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
