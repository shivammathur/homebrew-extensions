# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT86 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a71f47bec677baa4b8c41445e3ed1cbe03a6e6ff712a45d661f8c8d4c85ff4ac"
    sha256 cellar: :any,                 arm64_sonoma:  "253012e0c8294ea838751f94ca5bf86430472d6de9b795e1226cfc8fc6e2f41a"
    sha256 cellar: :any,                 arm64_ventura: "3c430f6373948e4177ed3e088c05ee67ca327251f02038c71d9bc090c1df31db"
    sha256 cellar: :any,                 ventura:       "2e9e85220a47d6d3fd897208782f3fc63da8f2efbe8c49ca1cda121f799995f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5541ba8ae063078faefab93ed84236d4471db359e016c4eb8182c1bbf1322d13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa763eb622822f911b5fdfef3426667d10157eda57e0d8ee2af8f13628f8dd11"
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
