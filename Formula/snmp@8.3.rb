# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.7.tar.xz"
  sha256 "d53433c1ca6b2c8741afa7c524272e6806c1e895e5912a058494fea89988570a"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "11051152d3dc109b944815628b733ddbc7c2a6bf8e4bee922d85f9d19f2eb929"
    sha256 cellar: :any,                 arm64_ventura:  "08ea2d5bf7f0784c7f8f3c42db962114d2ea591d5cddfe830138ee15d1022925"
    sha256 cellar: :any,                 arm64_monterey: "9681ebdea18fb75f14f7df7cda65ba898139780556e92a8903ff0ab7bd481c28"
    sha256 cellar: :any,                 ventura:        "1042cbd604b9fc90bf12b7243764726916a7f61ebba9221150a37d6d8aa52c04"
    sha256 cellar: :any,                 monterey:       "0e71c4289ebf045c1b6482a54c656ea8c7d1f881bc4277ee37cfcd93dcab2a71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9fefbeaabba503d85dce88596160d92adeab9ecfa0c0b36bf1423d1ddff92eae"
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
