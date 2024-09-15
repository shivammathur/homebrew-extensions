# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT71 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.9.0.tgz"
  sha256 "0a108e0408e8b984e5ae8bc52824ed32872d72e3a571cd2a5d2b63b200215ab3"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "92e441d17cfecf579ec82a8da5e2f4838338e18921fb02f1308709fe156ea797"
    sha256 cellar: :any,                 arm64_ventura:  "34e9ac39dd4cc301d06891b65c7c3f7fdda362acca4908f458108a1e169ea04a"
    sha256 cellar: :any,                 arm64_monterey: "947b9fa35aa27951c09b24fdd1e487061834abbce3d228f0f6058f8fd3949b44"
    sha256 cellar: :any,                 arm64_big_sur:  "71f904e44d3a131853d48a2166bae1c4c0bc9c2bc80fe3d0316e0c51f59b1b04"
    sha256 cellar: :any,                 ventura:        "defe7f67de871b235432692df6d61744c4e6f9adedb284d273443dfc7e66581b"
    sha256 cellar: :any,                 monterey:       "3308409289efdc2b87284eb6a5abde6fe0e7a97806512678aef5815a155b8059"
    sha256 cellar: :any,                 big_sur:        "0efcf1885caa9e86608204d43381ab528f097763d495462784eb47d983301e38"
    sha256 cellar: :any,                 catalina:       "3ad22c75d9f0bea015541d00c943085247d296e2d5ce53b306d511f00c45e060"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e88b2e43462ed2b2e27de0a801b23101d535c7316faa23ad09d9e3f0394e6249"
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
