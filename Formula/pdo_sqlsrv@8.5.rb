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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "c76a91c7734c70c50749d292dedc3d74d9e113cd211b6cb628f01f8bec42fa4e"
    sha256 cellar: :any,                 arm64_sonoma:  "da315a8bd4ad75637e042b2746f698b1523de189817579f195cd7010778acd43"
    sha256 cellar: :any,                 arm64_ventura: "6634608a0637da21966026b655433b535b46194a549e7089c06b4bf09e87a83c"
    sha256 cellar: :any,                 ventura:       "88ca1aca6cf2265f16123c77f4ff6e65ebf3ba7363b11795a0830dae032defd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cbab0ff337bc0b9a820b8ed2cbb7fd1db04a2417602890ea1c6bd42bc2e3f7fd"
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
