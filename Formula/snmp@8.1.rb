# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.19.tar.xz"
  sha256 "f42f0e93467415b2d30aa5b7ac825f0079a74207e0033010383cdc1e13657379"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8f3cbb4e16bdf16dadde6d0b09e50df4f06890bb065125eee326f6819a9fbad6"
    sha256 cellar: :any,                 arm64_big_sur:  "82ffc23d498a3c5c30fd646d6b220055a15e3018f1fb8083f81cdd139713cb42"
    sha256 cellar: :any,                 ventura:        "0f1a2756a5c4674b28353329d798e5d28b0e504a1d29ae38b46ab2a7f080de60"
    sha256 cellar: :any,                 monterey:       "484012c57f81169b3f19bf5092af07256608dcd0276daf8b5e72100433e3850f"
    sha256 cellar: :any,                 big_sur:        "19b841e1f10e5e4e57a4a77afa162ff1e7567436f33daf713048086f499fd58e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f380b315dc3f8cbb89c6839db2625480467aa624b7875ded59f0162b73de1be"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
