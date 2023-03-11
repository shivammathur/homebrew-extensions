# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "79d8bdcb3b88229c180ef179c9611e230ffd9c95f3550fcf440fe37fa01da3e1"
    sha256 cellar: :any,                 arm64_big_sur:  "c51e441bd2750bf05fbe2e2a2e6e5511a9a55916aebeb4e8cbf31010ff681243"
    sha256 cellar: :any,                 monterey:       "3b6214bfafee883ccd226d5038c3d28bec4d2e9f57fb6dfd870bab2e764bbb5f"
    sha256 cellar: :any,                 big_sur:        "7166440b063d0241dab41937a9fb537d5dc73a2bd6f49c786e8bdc9a4dce0256"
    sha256 cellar: :any,                 catalina:       "add1570e0f50b8cddfe7cc1b13eebe58d429bcc9a513e8860f69559862948224"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2b351f1d2169de719b0df879d9d753fe501dc8bad55f81635c520ccc8f8db2b"
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
