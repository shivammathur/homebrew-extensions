# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.2.tar.xz"
  sha256 "4ffa3e44afc9c590e28dc0d2d31fc61f0139f8b335f11880a121b9f9b9f0634e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c24b9bc8fb9f0b506801662cf0dcf1245799806b7bc8ff3c818230757863c5dd"
    sha256 cellar: :any,                 arm64_ventura:  "6642e1612e767f0aa5307e8737b69f892efb4fe9a34492b8a55ede21a5b323bd"
    sha256 cellar: :any,                 arm64_monterey: "6caf5ba26b6de16b65b25802e323013d0e194a171445a5ee76f1798ca9d11af2"
    sha256 cellar: :any,                 ventura:        "22b6b0643d179263c71abeff41f953f3f10b3680ce0481250faee55af8c36134"
    sha256 cellar: :any,                 monterey:       "1f49b4ede722bb70b8209227e65bc85d8c453dc952e17068695a8d44f5a454c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73821c75e92d241fa6cded613d392ad9ef5af6edd96028a75d3363dcaa025bfb"
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
