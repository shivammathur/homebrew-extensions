# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "40bd5e22d911e2869d1f323ba98dc6b7c5c08c4f22443b0b6fc03ea82c8bdcac"
    sha256 cellar: :any,                 arm64_big_sur:  "586be41ac5ea8f848add3f6227db4c19d92d935ccae6dbcffff04a30c359ec1c"
    sha256 cellar: :any,                 monterey:       "6ce12ff023b600549bb27e1c24446cd0d9b64ef2999499e5a4db825b0ff079d0"
    sha256 cellar: :any,                 big_sur:        "ac052720a333f01289294df2c3f1bda83cd94833222335429d93f1027166da60"
    sha256 cellar: :any,                 catalina:       "a858f20fcefe04b262370ef7f22eccbf957f6cf4ad496cdf3a87ef856c0711c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "161837ca1e4700693877f578055a9f3788ffba2f48b5424cf9488ec71475ad43"
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
