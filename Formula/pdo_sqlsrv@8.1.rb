# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2580d34f619d29d9262f035ef5c8dfe813c02c44ab0b1d3545ce6b0b893dc6bb"
    sha256 cellar: :any,                 arm64_sequoia: "c0891d712e32cb6140371105a75368eae1024144edb38e46f7311cb6adf6471c"
    sha256 cellar: :any,                 arm64_sonoma:  "042782e4b62e1c68b342f4a8538e6b89320b941dea34f2935056d08879014c58"
    sha256 cellar: :any,                 sonoma:        "c114f2cafce9fb9dadce475ab35acc0cc7a936ea4b4c8dcf0a956dbd6a243035"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eacb82085dc62700dc7d658569ba657f798c15593eb82b80a2c8dea1592c1e86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "241f05c0da948e8b094ecaa8489eb115c461d9a6fe7f78fa62895e5e588434b8"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
