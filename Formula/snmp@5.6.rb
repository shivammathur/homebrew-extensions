# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e59f61709da3d6dd00f31446beb9574a0d2331ce.tar.gz"
  version "5.6.40"
  sha256 "bc226d7bc4c4557a8305f6c1257bdd15c83c9f726f6ccee94982fdf87d005443"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8121f44e6e6001ec38eaf51cf4ce0f2ffb4700e49ccf530436512c8fc6149b95"
    sha256 cellar: :any,                 arm64_big_sur:  "6273803c43b6ee12823605470aa165954d450b13eaa488777559ce9eb7beae3a"
    sha256 cellar: :any,                 ventura:        "fba74db922f82c4a62d8a870af58e1e0a0d9e949840da1d6ee2c0cbacd41f83e"
    sha256 cellar: :any,                 monterey:       "1dd0836845017554ccff2de0f00165d41755d37a2911956d7d560b493bf5b04c"
    sha256 cellar: :any,                 big_sur:        "1db36dacb5321358391eeac17d7efa571f9665ac942d3cdc6aab391739c0775a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6600db0c1ee416666436940c812f474196a968bf518f346da520c7648f3bc78"
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
