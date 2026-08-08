# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "b5c63aba996002cd0318fac801c036d9073a8bcf6d0b8149644fe74427347413"
    sha256 cellar: :any, arm64_sequoia: "2bc4b11d824fcb83d677b63ecd8754ea67cecc372a09db090b31e3a70250614b"
    sha256 cellar: :any, arm64_sonoma:  "87339f1d09841ee3445fecd5e197dfb26ed0a757a53a2ffdaa96f77e51f3be64"
    sha256 cellar: :any, sonoma:        "8dd9f380f6e3d1a2617c039e822b35c074c9c44eb328cd411e3263c89657f924"
    sha256 cellar: :any, arm64_linux:   "35873e7e39fe4691bdab5cd493d81dfa44dc449cfcbc88b5f510f54bba0e5e86"
    sha256 cellar: :any, x86_64_linux:  "1ca50bfabba922e4e3aae567efa2b8426aee6dac2259965ee02c10b41f4801c5"
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
