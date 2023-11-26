# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.0.tar.xz"
  sha256 "1db84fec57125aa93638b51bb2b15103e12ac196e2f960f0d124275b2687ea54"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sonoma:   "898e39e54da84bf3326b7e8c614040285dab86ff5bd52ae5c618c796e2ba1789"
    sha256 cellar: :any,                 arm64_ventura:  "d725c88d5447b3a74c12f020df64298d68e385a507a2426288a3af77b0e8f350"
    sha256 cellar: :any,                 arm64_monterey: "a58083125368bf021b7078a6236d57702a67e0aa856bdd39a0bcb7b29dfcedad"
    sha256 cellar: :any,                 ventura:        "45e138c4703f007517b4fc9e9af6171bb784d6df2af183c4639715ba26a927c6"
    sha256 cellar: :any,                 monterey:       "7ce3c012030043d8010d9bab3cdc29259ab868d037a71a18e3066ea6bf40c66e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1029da094def0f203ba9d930a59eaca36db02797d3f81eade2b3362959478740"
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
