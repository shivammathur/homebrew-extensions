# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4f3b62df945a62a879de5f690c5d8980a3209226.tar.gz"
  version "7.2.34"
  sha256 "31c4174a2af95e846cecbca0696239b94717252571f5de444e17a3fc1d13e4e3"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "be1f77610c5be997ec940c949b01a14c5d447299936d4db87b5042cc2b211615"
    sha256 cellar: :any,                 arm64_big_sur:  "0bc3175b0b6023ab2c8c010cd192c557dd40b1a64dc122152154ba6d52fb9318"
    sha256 cellar: :any,                 ventura:        "32429c29ad076c074d03406baa5b6ba3ed4bf7a8283d02bddd11aa9e7328be75"
    sha256 cellar: :any,                 monterey:       "731e6ae038db361e865cad8b5a15178b330a4bab69ab0fafb9965cfefc5b8f39"
    sha256 cellar: :any,                 big_sur:        "4fb0ae25268980bef34b99620109e392c01a120191ae98fa6fd1e0650c36cf5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48a6880bf79aae1e860c431f2701dd7f71e2a5e21c72328049634ca629b4e916"
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
