# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT85 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  revision 1
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "972c9583733fc17d5a34fc04e1f96f5337899837e24215758bcc7a5acfe60bda"
    sha256 cellar: :any,                 arm64_sequoia: "a8b7d8f8f87b93492cd7a8a93f16e46b18948ee1b269d5816a5bb82948cfc928"
    sha256 cellar: :any,                 arm64_sonoma:  "2233a2cfa4702d9f98fb46edc33a4963a99e1b9ca8fa2deea1f3a42d3f095781"
    sha256 cellar: :any,                 sonoma:        "65f395c034a3aa3d1590dca18efce7bceaf3e329043d508fe7160d6c14adeadb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6de6ef262f5b16e8fac4b0f90c42c5a2b649dd3394a5ef949b72ee385ae9505b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6499a1ad11a215f1a3a1c1e8f6293d04948b22f30b027e6eb91e56b12ddac1cf"
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
