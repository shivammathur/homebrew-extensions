# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "5eb3afd68a4904659b2e18fae1289785bd495f12dee180179e9e7421a29deb4e"
    sha256 cellar: :any,                 arm64_big_sur:  "3a93cc3288568fae6799816be277e16147075197d162f28612928ff477db1b6a"
    sha256 cellar: :any,                 monterey:       "f338a6a0ccb4493bd86397bd9a5664fd2e7a27f9de64acc038d8c47d2049987a"
    sha256 cellar: :any,                 big_sur:        "9531d34142ad698b0c284780f829f0d4a7b34b7a200b81694cd48968906f54ec"
    sha256 cellar: :any,                 catalina:       "bf3789942d33d3e0f34528668cc4b5841f388483f66bfb593f737e24b335b3e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "87a0e2a142a10ea56487049fae5b2e6b89c717f54e0be6a89045255f19afba9b"
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
