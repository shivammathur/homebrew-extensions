# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c9b656d85cab6bd2f0a200276cd59f4142a48472.tar.gz"
  version "7.1.33"
  sha256 "900098dc8cc12caf1e33cf1174ec8d4abb566db95145c4948cb7a61fe3c831ef"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "cac4c26f6a758710509e026429afe033090e1a3d81b8ee32bc9232f011dd0982"
    sha256 cellar: :any,                 arm64_ventura:  "500e031ae0a587465c9d1e12872a759a65d37adb0a58cc16943a2ab7e5aa1402"
    sha256 cellar: :any,                 arm64_monterey: "33477010739d73ec55340c092c5a5d04f62fdca0fa2d0e1b043f777d34c6b1c3"
    sha256 cellar: :any,                 ventura:        "6ceab4c0d8d91fa2010a981aa1962350ff6a01b13826f48e0bc2bf7d16291d09"
    sha256 cellar: :any,                 monterey:       "b5eee64386e8a1de68bf42d6a022d5bebd45aa3157c98f28044325fde7b18cb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a74bae7a67b6702db7fcbf807151738d92537e050ae8b8e2d1f78b42afef03b7"
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
