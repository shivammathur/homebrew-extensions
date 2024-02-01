# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "49e28ba2559b8cd5f86b7d61bc955d1e3132de7f3afae0aa5c16c2689ef9d7c9"
    sha256 cellar: :any,                 arm64_monterey: "2287ee40dc6d3f3bdb6a79b7eefed618aaeb92e1d973c4267d2fedf0336c7e74"
    sha256 cellar: :any,                 arm64_big_sur:  "423d54a2ba1dc839a5fb8d18835b49840e446e3c097bba0e73318f4d15e278e8"
    sha256 cellar: :any,                 ventura:        "5fb58275eed846a664b52869d955a368269b38f6fdbee1b4a2f686a88abf5933"
    sha256 cellar: :any,                 monterey:       "0da5986fe99333e16573cc9c34e91cc25dc347622a2ed3b4fa80c88cf75dd180"
    sha256 cellar: :any,                 big_sur:        "f3d61c54d86e46c29d83d043fb602b558b4c5d30d0a2bf077e926f051c02982f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f3ce4faec8a68bf363c9895959b3cd1558ddbdf9ce12914b811838599cdeca64"
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
