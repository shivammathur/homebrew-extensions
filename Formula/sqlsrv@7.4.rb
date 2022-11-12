# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT74 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.10.1.tgz"
  sha256 "5cdaedb4d8a286343e6b3b99992d9fcb44a8fb69dd02aa5d7bc20eb2ea5e59d2"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a616734daf84130ec61ef99d0711217ad9aad1f1bfc49bcc3338c91a86352703"
    sha256 cellar: :any,                 arm64_big_sur:  "6ba75f6d6ecb031ec1ebaeb7f136e751c98eacbd335463ba7450decd02bae43d"
    sha256 cellar: :any,                 monterey:       "60a81a8186f2a0060dfc04c3aaa4e4a3b9afb7ef0097b20923fadea0bfa4e163"
    sha256 cellar: :any,                 big_sur:        "d05323919af5c0ab1d63c73f3996aa79cf2e80280187027563ee72f81bfa8f93"
    sha256 cellar: :any,                 catalina:       "01a5398de4452dc964b792de26a1670c8b45a4ffe9d3561bd88eccab08d962af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "330f44bb4d5cd3b414e937a8e1f3f5bcd13031b8c7b01e9bd01d82709a424536"
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
