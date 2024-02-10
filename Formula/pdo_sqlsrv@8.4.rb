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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "7f2145673d430750b61dbe5bbdd920233fc61212434bdcb140c1e7b3f3c426c4"
    sha256 cellar: :any,                 arm64_ventura:  "e9ce1324a949f16e62237d1f41962f774c7af33292e5eec8c102d21250b0714a"
    sha256 cellar: :any,                 arm64_monterey: "6bb34bbe354b01b23db2f06ecc8f29729726683cfb5790a6c6f9dab6041aeb19"
    sha256 cellar: :any,                 ventura:        "97eb9120ed9fcec532131c3264ec3841f9c77aeff6c134dbff71661a6f3768fa"
    sha256 cellar: :any,                 monterey:       "bcb1126380484091fa08bae6f74ac7f011dcbc1c3bedbee02372ac854864827c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb7993fdb19c62ffd663b1e6fac9cced90dcb6e577b486a924d93f0889f4e67f"
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
