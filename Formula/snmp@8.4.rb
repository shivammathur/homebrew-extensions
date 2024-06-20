# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b5c6d57c051a63667c377e0e76c10e8a448a9bea.tar.gz?commit=b5c6d57c051a63667c377e0e76c10e8a448a9bea"
  version "8.4.0"
  sha256 "ab036d74cd5d20794fce1f81da9f38513d12d8c4ea2e5e0080fca0a3bbf6434d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 47
    sha256 cellar: :any,                 arm64_sonoma:   "fe2de901c94961a6247e70a9d6e00c5229d18b220e3fa249ce740f35b9279930"
    sha256 cellar: :any,                 arm64_ventura:  "1c7d40bb00bc65bd1c348e7d1464b0b72d167da02113762acf79157db7ef5a2d"
    sha256 cellar: :any,                 arm64_monterey: "5487e93642c34294adbf3d9a8b4b77a8f3510d95a0763fedb1829991ab92285f"
    sha256 cellar: :any,                 ventura:        "442fc501f075b00a99636f92fac67ea7269a1057c9d6d44c8ab17a04822b8834"
    sha256 cellar: :any,                 monterey:       "a1ec10593f7f91f99208c00d130f2b823306c84fd94133d48c898ede204802e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b0f9de436b261ff1c207906f4884a59fcfa78253d520262901b07af778f6cd2e"
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
