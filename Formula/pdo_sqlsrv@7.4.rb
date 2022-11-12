# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT74 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.10.1.tgz"
  sha256 "c7854196a236bc83508a346f8c6ef1df999bc21eebbd838bdb0513215e0628ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ff04c13b6b38fe0e1d687d2c7658aaed7c6ddfe1e3e9ba582db9f2dde64b01d3"
    sha256 cellar: :any,                 arm64_big_sur:  "3cca3254bd673fbd1e5d57b50880a69889c7e130b1f34990087e4d66179f75cf"
    sha256 cellar: :any,                 monterey:       "7658604d5e09a1994220de10b29beb18998900313e294e11603ac9ee3f87fb5f"
    sha256 cellar: :any,                 big_sur:        "8e1f8504be45debe984909af2b849d80706350fe85d3de4b6f7e8d52ed876ac5"
    sha256 cellar: :any,                 catalina:       "4bf4d1e894d7ad96ef4782f55b095ba1d167880af5dc277e9ad416241664b54c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "365d346d357230a096735f7e85ab094ed03cec94fd0cbd6d8e8495e176808502"
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
