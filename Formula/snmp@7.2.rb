# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d6c57bbc42a5b41fb67f63efc5944d217049e5f9.tar.gz"
  version "7.2.34"
  sha256 "97cdc321dfda41800a0082e48b66780cef2515c366066b1a1bc7493e09d2b43f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "03d17f5760d341da6baa80dfbe3cf81d3d49fa1513cc823a23fc6fe191b12f33"
    sha256 cellar: :any,                 arm64_ventura:  "73edf85ff38f9f83cdad7981f64749b7ef6052ac9653ef69c6070739c500381e"
    sha256 cellar: :any,                 arm64_monterey: "b7581997384047464a415f938491dba1cf0f91a64ca34128a145a2675f38733d"
    sha256 cellar: :any,                 ventura:        "16688c4d876aee81e5bbe5d9d2465bf5b9ae2cf2c464b8c52a47912aab2000ce"
    sha256 cellar: :any,                 monterey:       "0c12ae23070737719effc38417706e4ef1bb79e08a2820ae99c5270e5701bcff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "630b91e2cbd0bf9c7dbbab0052036ead8f0018947aeeba18b0e4f7257ac61c3f"
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
