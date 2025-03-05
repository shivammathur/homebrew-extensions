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

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "3fe8f4aa5fa47b85ef30428f639c5ff6923f1b3de6e5a8b1de5ac2b031bfd1ad"
    sha256 cellar: :any,                 arm64_sonoma:   "316e2132e3ee87d75f359e53782ca05023ea82dc57910c8a730bd02ccc499bd6"
    sha256 cellar: :any,                 arm64_ventura:  "9d7aef9c7daf38e0f9902d72c6a1d7e7ba222238f7e4a1f0f093b2817100ad9a"
    sha256 cellar: :any,                 arm64_monterey: "4c7ade343d5b9a613dd14fa9b81eee5f3684d35da0a873ba4883ef70cd76a6bc"
    sha256 cellar: :any,                 ventura:        "7ecb7e236eac1582ccd21d148708dcc984fea0458f711953222cd5c1f3bec190"
    sha256 cellar: :any,                 monterey:       "7a92e1f15e2de617af4482d1091a39e70d80b9d7b92dcc9404329f4b5d359eb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "944b01ef6fd7578ed4eccd870f0386aecaa7a72782a7c7cce704ecc533a2a840"
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
