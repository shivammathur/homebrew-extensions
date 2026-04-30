# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "25e97833be9dc257b2c4f55f72e214910544e53c311b4c6c59ec9ba3a389bb29"
    sha256 cellar: :any,                 arm64_sequoia: "ad25489222003af210318be5162ae016168a3723f59769c2103658f6187759d0"
    sha256 cellar: :any,                 arm64_sonoma:  "08e0dfa2b28cceb8f66237697a0ccadc4a441aa7d35128f574c9080f613fb2f6"
    sha256 cellar: :any,                 sonoma:        "61046887d69131d6abc66e1d44fd45b9aaea2b1e5be89f168cee2b05b73533e5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "00e1260c81ed142726119b436d3cc832535142c78c663698b5468abfd40a323e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38024cdb09e80604b72d5d770680f08598bc0c3420aad250bb66d3e00b710457"
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
