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
    sha256 cellar: :any,                 arm64_tahoe:   "3856edaca91c2dbc6d35ea4886ba253528964eb4604592c7791834b3b3f2380e"
    sha256 cellar: :any,                 arm64_sequoia: "1d1aebe17680491e76642b31546cd155bf15312d27216a79a8156088c12ab589"
    sha256 cellar: :any,                 arm64_sonoma:  "f2351c994570aad8e3bdc384adead1974be9af55efa91d8ecaca0b622dc73fa5"
    sha256 cellar: :any,                 sonoma:        "13ade223c686efb44e0109fa5b8a80e28bb84a478913e4ccd2098f951c1e6dbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fe713f4f08e8b4c39cd6f8f3a3658bc65ebc087e8a8220c1252df5c46961fe08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee1456252131634eb5f856d8f45383e7d63be265cd16729552fe879f5fefa296"
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
