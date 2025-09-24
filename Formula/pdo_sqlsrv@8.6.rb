# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b1abf1e18df833c955c645ec33b7d0a43dfae5275b41cf912e347c38787ccb18"
    sha256 cellar: :any,                 arm64_sequoia: "ab9be34199664f02a29652aba84bc0e68cf462c35df012d8d94bffd86e78e5f5"
    sha256 cellar: :any,                 arm64_sonoma:  "af5b68a26433a8e256f74eb50c5880494965ccb5d00cc7b8f73efc0aba37cb0b"
    sha256 cellar: :any,                 sonoma:        "157346ff6e6f1b08de6ea653c08003b89b742e4dcc10abd63ad9c615542cfba5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "84da6c04726d3df9d5951ff82505334581051d01692336591d1e595b7b899cbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21dd3e7c15d1747132d4ea2a71dfb9da0888aea50a3846a948aef48bbb459520"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    inreplace "php_pdo_sqlsrv_int.h",
              "zval_ptr_dtor( &dbh->query_stmt_zval );",
              "OBJ_RELEASE(dbh->query_stmt_obj);" \
              "dbh->query_stmt_obj = NULL;"
    inreplace "pdo_dbh.cpp", "pdo_error_mode prev_err_mode", "uint8_t prev_err_mode"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
