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
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8726dbe9c5afc9cc5136508c307d656b606e701b98a9a55fa7acc2f32782f9f6"
    sha256 cellar: :any,                 arm64_sonoma:  "a9bde95b2acc73a4aac1a7df004586e222e9ecc54b40d77bebba51515db48266"
    sha256 cellar: :any,                 arm64_ventura: "412b2ad1eca3094a73ae37d2f745bfb8aeba7249b98714b837947bb3e02fd553"
    sha256 cellar: :any,                 ventura:       "13c5ca9972e2267575fe4507402820a2d8b628a55db220719d1367e6887ac5ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ca5304dd5e61086dacfc0760c45df10d573244e814f128411a919bfecf332a2"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    inreplace "php_pdo_sqlsrv_int.h",
              "zval_ptr_dtor( &dbh->query_stmt_zval );",
              "OBJ_RELEASE(dbh->query_stmt_obj);" \
              "dbh->query_stmt_obj = NULL;"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
