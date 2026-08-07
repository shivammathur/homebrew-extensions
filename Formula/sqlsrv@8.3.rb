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
    sha256 cellar: :any, arm64_tahoe:   "ae3d0490cf2f4554ed8826301908612dd79d1e3df5fc1fb5a62cbbc6ecfd0891"
    sha256 cellar: :any, arm64_sequoia: "360c19a50e0bf81dda1067dfa06ccb2aa5f2e032ae0d24bfcf781c6734c14944"
    sha256 cellar: :any, arm64_sonoma:  "592b5cdae51df80352b4763fd023e086ff3417ec47014afce7e341d0f5aaf9e2"
    sha256 cellar: :any, sonoma:        "47c70d011dcacd46a6d11c4de0f567fe2f9e95d75b99bf49780f9793603af572"
    sha256 cellar: :any, arm64_linux:   "79f9f63362d03c07d37ce240ea6c6512f3df687caaa3a7b4b7970bf89d8decb0"
    sha256 cellar: :any, x86_64_linux:  "cc190e2ca6147a9a52e0648e41b767f332a96c8381406dd7c5985064dd4a82d2"
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
