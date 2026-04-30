# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT85 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.1.tgz"
  sha256 "7c4ea8f25ebbc8999084239e7e0ef75315097e013df0e290fcef76c3d977b9d8"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9206fce05594557dde210c444099b52a6a230dc421b62b161f432dcdd612df3c"
    sha256 cellar: :any,                 arm64_sequoia: "ad3f9239ecf4da509fd6d128fa90cc71fe16ecc60e4b081b8b1ac3b1157e44c4"
    sha256 cellar: :any,                 arm64_sonoma:  "adb2a0a6a2076f21f38b030ac299dc7ae70387e026887cfdcbbd8d77e0a47df2"
    sha256 cellar: :any,                 sonoma:        "34f2d36ae897937ae95bc2754e9d78481c9cf7d4a531664c80ea4cefd348d53f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70b65791167d5c38d1f9fbca0a9cddf257f7abb56db2c509ccdc7998b7dcae51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e7ddf710e59fafa89e91970f541907085b1020338a2dd4a8a73c913ad94563b"
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
