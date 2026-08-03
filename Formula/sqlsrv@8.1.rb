# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.2.tgz"
  sha256 "be82e726b06899a8a8a456bf940484963d7cf424ae43149b183ab52c43adb0ad"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b00f612c7722a5b9fcae0b42689a6b37314a587f0d5da5a752a8a1b44772d4ff"
    sha256 cellar: :any, arm64_sequoia: "3a97d62d07042d2df9d30a6938dc332eab9e555d86188bf5ab8472f563512059"
    sha256 cellar: :any, arm64_sonoma:  "1537a3495dbc82929f747a88ba2591af92c78a345695de53120967d39cf46dff"
    sha256 cellar: :any, sonoma:        "60cfca63f88838a00365ba89a47a321004349931ba61592f386216038bda200d"
    sha256 cellar: :any, arm64_linux:   "96c074c4d855e7751602200476174d98a470c4e1df25a8570ff1d8189d4e8e68"
    sha256 cellar: :any, x86_64_linux:  "f94d4d54bab92243c3edac5af5e92e95e788732694fed083a98b1687974e8d1a"
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
