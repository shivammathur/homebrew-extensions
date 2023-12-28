# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f128ea2b2212b5ead79c5f3958dfe0be898bf45.tar.gz"
  version "5.6.40"
  sha256 "e83869bb7ac2cb773d4456ac6409fed55f36779ccc28b2bd8a67228538e4cf4b"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "a0d20efe3fcd3c2ca0779b049058f376aa337653685e3146e604ba0dd58e1c58"
    sha256 cellar: :any,                 arm64_monterey: "afb89c82af2db01b0c289d8e729731ad92e2c89e796f9dc4c81d0e7372e6b5b7"
    sha256 cellar: :any,                 arm64_big_sur:  "caee560c53e212ee6a1670078d05225e6ca323b3827fff7831f15c786783af68"
    sha256 cellar: :any,                 ventura:        "f1ba3ca25d7b7945329f02dd116e09a643063de9020955239f9855764bf5dae8"
    sha256 cellar: :any,                 monterey:       "b3c6130b2ce7c9f8b18fb4699054e6c2c9ab0dc0abb7f318e601e1469eb0b3bb"
    sha256 cellar: :any,                 big_sur:        "efc9804427c8a594fdab00f8b2f07778993a9ec82c0295bd7aed76cb54208248"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b7ff2b34bfa931e24732d399fdfef0ac7f1d1947e7d67a034a016bf6df6bc30"
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
