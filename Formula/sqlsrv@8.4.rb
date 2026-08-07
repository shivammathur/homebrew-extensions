# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8c60bb86a386cd9c8331ace8d7b287e71fc4268d32a373f174005c3d479a4381"
    sha256 cellar: :any, arm64_sequoia: "89af9ba436f8dcce5d98a24590df76c8b01cb23b1b889f371b2c1f9f256904cf"
    sha256 cellar: :any, arm64_sonoma:  "2b3338db59dfe8263be62da2e78e60089b5304bf16022918913b33fef08a8fed"
    sha256 cellar: :any, sonoma:        "9096502cccdf2effd7bdc64e299fc7469599f75a48788e512e3eac28665e7e59"
    sha256 cellar: :any, arm64_linux:   "7ca7470d650dab6b462784d57eae1c289bc2a047354e034405f8071ae259752c"
    sha256 cellar: :any, x86_64_linux:  "62b89b974ec7d8dfb9a31332383b95562dbb699992f0f48b77a369933d2a4b2a"
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
