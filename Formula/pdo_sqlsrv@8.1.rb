# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "57216c7a50af7ea30e49be66c0d52056864a77c7affc44db58e98c826e4eb9ca"
    sha256 cellar: :any,                 arm64_sonoma:   "255dfebab63f90ed72c2cbd95e0a501e1ba33a83f380ce0774daac27a27c7885"
    sha256 cellar: :any,                 arm64_ventura:  "f24e42bba28913b49284601692bb09c362571b925b7900d2ca757ce10995b187"
    sha256 cellar: :any,                 arm64_monterey: "542409e67b404c87acf70d1bf1bbf5d705264ddc9db02eb74a2c5304d5ace799"
    sha256 cellar: :any,                 ventura:        "2aadb9f672ad90c40e11496659cd25cdc919cac2f02cbe22ed02b29e1fe81e5e"
    sha256 cellar: :any,                 monterey:       "77994ce4b67947ffcc0baeab2decd4bd013147b58026b09572095d90b217ae8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d75cf8aea479469d76d5fef13f8600144b8d59251a953cc80aa447b875ef2f82"
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
