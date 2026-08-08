# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "b186bb21fcbd458a39691ac678167205031a6495c58f9a8095ea429c9062d058"
    sha256 cellar: :any, arm64_sequoia: "dce573d5765bf4e889bbe328e5bfe6dd5fd64b73b5e75176c746b77225d55e6f"
    sha256 cellar: :any, arm64_sonoma:  "1f22b25eee50bde1275fc16082cf67ea0c0bc30fb642775513a1b404c3ca37ae"
    sha256 cellar: :any, sonoma:        "2f3372758b5bb4b126a19e98b4edaf184d78ba135ef7b6c85460b74e93c6305b"
    sha256 cellar: :any, arm64_linux:   "65ebb345c01d937e4b6573909d1bffc375da7a7f206c874422f907a7e5db0944"
    sha256 cellar: :any, x86_64_linux:  "bde46e2d9250679b4deacbdfcc22e2ac71484ea53d8f9ed55f6298cbfae6b542"
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
