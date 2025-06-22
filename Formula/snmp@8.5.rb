# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/89be689f778430f93bac04d75248b5b6fc593571.tar.gz?commit=89be689f778430f93bac04d75248b5b6fc593571"
  version "8.5.0"
  sha256 "3e9cba04d39f06f8ac92fa8780bf98f0c60dee23f5f574dd5f3202c5589ad5d1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any,                 arm64_sequoia: "e86c3749c15a603cd25cd4d44240d6dfb0acae03fba25ebce487a7827f4d06dd"
    sha256 cellar: :any,                 arm64_sonoma:  "ed7343b14128d9d9be47f415e833da67bd335d2f979ec5841d022dc008bdeccb"
    sha256 cellar: :any,                 arm64_ventura: "ef323b85418f54c233fc0c9b8d4b2e8e1a8c3f2172fa065311fa8ed3d99866ca"
    sha256 cellar: :any,                 ventura:       "2b8a66e82ba541efc8f656e1eee07923cfe25e93a533287fd2e2a4bf7099b308"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6171a9c5534affa012276ed2b2ad4806a752903073c97bce388c4e929d380821"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efe3dc8e640db7b52d5e5e90ba8bc32181a57fa498022f1311b43b96b539f458"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
