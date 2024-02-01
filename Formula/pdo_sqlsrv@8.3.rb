# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "ad4e6458f5be1bda7cc39b375125ef27728c3ba91285a7e03203fe1f92898a3e"
    sha256 cellar: :any,                 arm64_monterey: "4acd5c5c51f80c36471412dfa10e74bf8a946b5c79670ea3315ccd23ade91b3b"
    sha256 cellar: :any,                 arm64_big_sur:  "8a8934974495fb2519319e7411533b6e987aec1e394d163aea1209f79cddf3df"
    sha256 cellar: :any,                 ventura:        "fdba6ea0e3f407b6f99f595a31b76455d4dbfa1f244e3fd502a9a6e21485e98a"
    sha256 cellar: :any,                 monterey:       "a731ef60ac0e0731727236016b5fbdc8cfb5a2c6083dddcbd5c6d986b7e305f5"
    sha256 cellar: :any,                 big_sur:        "e01d7fbe0857a5455914c2d6ba052ae441573c3481445a21722cb1196dc0507d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b5d5d08bc2ae11818761448fa57605ce955325d28fd930e0ba1db5cd9f708b3"
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
