# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "6320bb848689bbd1c28589ce577f3aefe22133210a883b003aa3b6bbb2157d34"
    sha256 cellar: :any,                 arm64_ventura:  "29c73608e771bd8d4b01d85126e7e1fab0aa583f2174f4cab174fca6f70682ae"
    sha256 cellar: :any,                 arm64_monterey: "046df591ea0e6be9998ebd933b4058c781e93b5112ecdc68d2f6254579b27b7d"
    sha256 cellar: :any,                 ventura:        "4f932d64306385631032c3728c07594a02136c5bc44bcd26b439e26488a5147b"
    sha256 cellar: :any,                 monterey:       "640ae62be2e6eb2ed6d75d1d5069d1ec95610f0ce2c477d7a27655b98f5c085d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5919d6b8641ec8237f3276e4edde5744488b335316e3d2d52e9ce3b34a32887"
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
