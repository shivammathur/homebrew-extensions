# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.1.tgz"
  sha256 "678ab60174be56b09c6916307700e716a4ff266ad53e43990a9d9740d4728463"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8ea0848e10125187c130bd226cfd812b791ad0617335f4e262e36fb83e345d78"
    sha256 cellar: :any,                 arm64_big_sur:  "307b6423ed4da33b2662fe35eaef6c094bbb95838ea7c0e9ebfce91f0c94f782"
    sha256 cellar: :any,                 ventura:        "80664c49a9d02ba3e2b036f361ce9d17797418e39ca704467b3cfa4da45163c4"
    sha256 cellar: :any,                 monterey:       "c19ed9d8b8cef954e21bf1d2acc00052bb6d16cb4c20556603d4657911eadf43"
    sha256 cellar: :any,                 big_sur:        "3a1ec319bef8ee07b58861741855e26363a625a8669f875c5cb08eea9379da6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50fb394ac6669582796620cbc8ad9260c2524e9c347fa865edc2738d8d858c83"
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
