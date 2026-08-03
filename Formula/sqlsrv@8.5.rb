# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "df5e8d706ec7cc8a41cfcff34768cfc7142d685bc5e182e3d1d2d27680050d2e"
    sha256 cellar: :any, arm64_sequoia: "4df9cb3b2d7aefcc52f173b641e8163c4f1135ab90f91e7457a8f9969006f879"
    sha256 cellar: :any, arm64_sonoma:  "4815d86b3111947f347702caa81b85eb6212bb9ca1d1e987b521763f18b198d6"
    sha256 cellar: :any, sonoma:        "191c697384353bf86a3299c8da92ef37b4da638d098ab3b3ffe78f3394f11853"
    sha256 cellar: :any, arm64_linux:   "0df231c1bf68baf542497cf75035cf1e4f03b87829b1ee8d33723ed515122e91"
    sha256 cellar: :any, x86_64_linux:  "27cb31a0f341ec1de4fe4f2f47429f9804169cf1ba49d4911df11ce49250b984"
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
