# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.2.tgz"
  sha256 "5084e7ff8ffca45fbe5d1cbfbe02a060883f84bddcd0687dc85e92dc7ba21c91"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c6c00fcb94ac5edadbb32cb6504f618796307a0b8342d4e93fc7dea0ea1c0653"
    sha256 cellar: :any, arm64_sequoia: "292fbd87846e3d994ca762e6003ab487ebcfbf4c726da4094de318328f142ba7"
    sha256 cellar: :any, arm64_sonoma:  "83208956ee221bc647d32e4136be9dba9a3b84e6116fb90db60f47e6abf9f2a2"
    sha256 cellar: :any, sonoma:        "75c8fc49f2d8e3379b95a95d14f5727f3599babf7f6c0963554c2b3809f90cec"
    sha256 cellar: :any, arm64_linux:   "8a9a1da8c67e72edea7f25d066c70e2ab45b2a88d6b54d84139d779849ca4507"
    sha256 cellar: :any, x86_64_linux:  "a340e30a648f2af62f140ad85899dfab8f910cd6a0bffab0eda72c0626340cd8"
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
