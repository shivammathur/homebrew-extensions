# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.2.tgz"
  sha256 "5084e7ff8ffca45fbe5d1cbfbe02a060883f84bddcd0687dc85e92dc7ba21c91"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "81d0049673b769bc03cde15bbe1fc71df2cddc42dd42d6ddf0b9e589574c313f"
    sha256 cellar: :any,                 arm64_sequoia: "4040af008b9ff8b4d65e773cb71b933e722f1df8b0e5180106b9ced2d7e8e32e"
    sha256 cellar: :any,                 arm64_sonoma:  "cd3f40e23b78191c96d7a6450d1317e19face1daae4151ece27951d28fe37069"
    sha256 cellar: :any,                 sonoma:        "8ef21a0f03d8f221070d0bc44e82e1e17802f4fa36aee9a980d51e553c1ff6b0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "534d21ede11139b27ee10a5346e1a116ee5a5db32990d926988279c302582193"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f804bb23f6896e540dc6eac38044f04cd89a7f931dd985a9a5e60cb24f1f1d14"
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
