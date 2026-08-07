# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "582e64f4cd156a635a0774c6cab1cd6ee917a6a9e65c143fc3877d30a81d823b"
    sha256 cellar: :any, arm64_sequoia: "30717c78db2a360156aa79d2d25c302697010a6e8d1166a857ce6a8b08e85d3d"
    sha256 cellar: :any, arm64_sonoma:  "3dd798db5eff6286622c865897d9b91b84ab1f6590a2e3116b3e97391e738373"
    sha256 cellar: :any, sonoma:        "084f2a790fb0ab026007b30e3c136351e6f019feb07df5229949e3b0461e9cef"
    sha256 cellar: :any, arm64_linux:   "345f99144429e2a71fbb3afef9f89f8381d95c615b1a2ba5e958eb742d055934"
    sha256 cellar: :any, x86_64_linux:  "14123607207069e5effe7e5202848142bf71251583e6f46fe4b535a6e83a7bbb"
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
