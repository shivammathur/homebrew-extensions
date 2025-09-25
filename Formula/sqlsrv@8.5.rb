# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT85 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  revision 1
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d93f8863d0caba43adfc3e3008cc1f5b8f5b06fcaa5f97450d7c67609270b3b5"
    sha256 cellar: :any,                 arm64_sequoia: "27beb31a5422bb9a1308fc347623a1c9a9adc8a77d3821c20b7634503cdb85e9"
    sha256 cellar: :any,                 arm64_sonoma:  "98c8bed5c4b62afb74d669eccba9abd344a4c948efa33aa9a610216efa799b8a"
    sha256 cellar: :any,                 sonoma:        "2bbec362c6703771417308456df7cee953f52821a9374d3a04de383ff9c501a9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d2d4d9b61a5a88942a5e47b5cd8db8aedf2da58bf9e9a62e958bd056ffb7c336"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4167994c62b6630ee69811a30be7e370e8cc7fce3e00d75ee5488dd6be2cccd7"
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
