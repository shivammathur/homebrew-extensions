# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "e96d88500a6912eeaf384002f29827bb049bd81d2285012e9f2f34d69c002a8c"
    sha256 cellar: :any,                 arm64_sonoma:   "1486ac00e2ba0ece4eacecb79f210153c583f5b1040b8c45bdf3bddf190083f8"
    sha256 cellar: :any,                 arm64_ventura:  "c86a321d8243a76adbcaa43316b53a9d249b36a611394c469e8bda54130fffef"
    sha256 cellar: :any,                 arm64_monterey: "a4d8a83894c43fdf4e1c797f88375b6fb38173e92903e3252667e76a921b58dc"
    sha256 cellar: :any,                 ventura:        "94768ba4683423f0f24834265625a67b97720b8638c060b27713e41547881cdd"
    sha256 cellar: :any,                 monterey:       "d931c3410d67999350c5965ad467c33c3613728dbedd1271d76644f006122655"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "097997ce8ae688791a2c12b7b5bee04e4d320291830aa38f737b48ba3782b467"
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
