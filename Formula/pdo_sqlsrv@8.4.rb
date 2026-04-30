# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9413470f32d14104d3e2574cfc87994d2568ef8f2207e86f4b708774bebf43f6"
    sha256 cellar: :any,                 arm64_sequoia: "8608c5f9fc38f02a5f6d1e72a4890bacd8c2589756e1a63230c2ec7522fbd151"
    sha256 cellar: :any,                 arm64_sonoma:  "53bfdcaadc18f38aa07c8cdfdf4561f4ebf767dd31803b35d5f7fa2cc393bf51"
    sha256 cellar: :any,                 sonoma:        "df34148342d06e14c297f1274ae373faf9d976fdaf46d2b4e1a2a6b40dd48dce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1180394a82a3968fc2a16338244972a4aea12e0372a2923d65fd98d4146d58a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "073c41d45cbe5e8433796763650f4f479079a1ce28b4f7804f87617d0be5a018"
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
