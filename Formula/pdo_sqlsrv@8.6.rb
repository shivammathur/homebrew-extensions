# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.0.tgz"
  sha256 "efa859bcc48d97f25268dbdebf1db25f25610d7fa36b3ee91073c1c99411e24c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2c25c865e45043b35c32cd2f8f4d9fef38d85f26903e9cde79e0e698391d2774"
    sha256 cellar: :any,                 arm64_sequoia: "1c116a8b26f5f39119d52e58c0e30cb79533b165c576c8f93cb8443dde7deaaa"
    sha256 cellar: :any,                 arm64_sonoma:  "dc22a24378fe098ce6cb13290472bab5cc5d5782f24276f6e9769bf1e2e30ab4"
    sha256 cellar: :any,                 sonoma:        "67ec4659975db8ec42d9991a1342f6e6a629a693a9bc1fd55dfbb8c4b0c6f281"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "19053f9a68b3bb32c95ac97da626fd95baf8b633ec56aa9158949d6341ab2ee2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "313c8f842852fbd63b245f00b97e01fa2712dd6a8be0fcc59ed6b82c78bedad3"
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
