# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT83 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "3dea4d253adbe501ea0f47b9eff6f7452b30b156adaba25b28b0f8b9cd2b5a75"
    sha256 cellar: :any, arm64_sequoia: "758c8078c0e38aee135b485514e2fac27a19a6176957b21e7c9f7a2ef2b70f60"
    sha256 cellar: :any, arm64_sonoma:  "a7e4b5d00fb5eaf7d2e4b232e33a9883a049386f4da9ef226987a28f3cc8b50d"
    sha256 cellar: :any, sonoma:        "e089442e96c978a70a4f2d24aeae50a218627e8598668001a80dee235d4217a9"
    sha256 cellar: :any, arm64_linux:   "e3025debc907c41fd537ca8bb4e3697f05fb2b09a8726ea1f985825d0b965748"
    sha256 cellar: :any, x86_64_linux:  "e3650c1f82e2fa44566219d88dbc152d7f0ea5010cd622ff2e958c2631b169fd"
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
