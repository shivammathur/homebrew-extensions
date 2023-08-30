# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "77d1cb3624fda970bfc7d50ce3821eeededb56ac32afe72acc5f18156c939bba"
    sha256 cellar: :any,                 arm64_big_sur:  "767f9dd2da0a7fa1cd1a62ca223d6a78e6fdce47ce46bcc918f7f0092268ba01"
    sha256 cellar: :any,                 ventura:        "0c898a1ab6fe2b69bb24227c329879d03bb6240ad0406916b66b18f2a2af12a9"
    sha256 cellar: :any,                 monterey:       "e68627051a4fd0f12752f28668eca9bdce51c5772e4c43e7205516f089718ed3"
    sha256 cellar: :any,                 big_sur:        "a96201b3ff5760f2f9f79d8dfd68d6c8758bf04ffc3854ee2b6553cc4e097167"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "30dc9b53b850507e90fe08299f6f8d88ed9cb3f34c150bed0b32b6953b915b3e"
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
