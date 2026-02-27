# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.0.tgz"
  sha256 "31d6c2835a05a7b6ed0f0ddb67556ca914652a57a571c26891f02d8ad99b7e5c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e4f5bcd5d93a018d1c8724a9a1a53f9233728b554e7c8c55674636e430d449a2"
    sha256 cellar: :any,                 arm64_sequoia: "06c59416dff0799db2a2cbf70e5826022e7bd214dc1d4ae7a1c20e4af9b1db49"
    sha256 cellar: :any,                 arm64_sonoma:  "0c6a35ea0510f64947db2be9abfc5d8f4b07fd3450dd53f56f06e634c108ba45"
    sha256 cellar: :any,                 sonoma:        "55a4d6d9150ada38c58875c8afe12a419c4c6322e30557fb6a61ea4d23decf33"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "41518b26132b56022a97dd30e352457a5615be9fe3c016d4eb3aa2cb2118292a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "187bb3b1374a05c12545f8fd61c6b17af93e70ace1a398cc616140a964a3e8a1"
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
