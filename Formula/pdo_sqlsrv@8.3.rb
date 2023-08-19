# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "602463e889c205c94b85b0256691ff389a951f3ee46116a56ad75f3ae0fd6f5b"
    sha256 cellar: :any,                 arm64_big_sur:  "e15428298d28614858335a2ad6ef8d5930e0db36b3e6fba82284e7ab9144212a"
    sha256 cellar: :any,                 ventura:        "c943101ac8abf98e6c523249decc63a5314a2f360b35dc4afee00e55e6815884"
    sha256 cellar: :any,                 monterey:       "20f45c573aa3de961a1d36887a7e8bfbde3304cb9282a1028f97269baef3b7f6"
    sha256 cellar: :any,                 big_sur:        "cf671c49a33277322a2005fe296f278d7521f3bc025178e785aab9d3294f5fd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fef7a100d0676fec0d808574c447250687f5e4456c6f04a0e11ada6d5d9104f"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
