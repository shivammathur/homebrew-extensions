# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e5b417c927f43ba9c4b237a672de1ec60d6f77ca.tar.gz"
  version "7.4.33"
  sha256 "7f9b8e85407c223c3a45e11c1bb4fbebf66ef7c9008277eb1ddba2b5d1037384"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_tahoe:   "c57e57a7b29a2412f4c16621955c215aa431f85982c992ecacebf69a3c3d3d70"
    sha256 cellar: :any,                 arm64_sequoia: "2e998e392922e6be953e38146b8b04d5564b000b2ff07ceed5a18ae69f4ae9c9"
    sha256 cellar: :any,                 arm64_sonoma:  "4081fc24e1aebbde3ff22cf638cd3bafcd7778519b81c32c29916ad63434432f"
    sha256 cellar: :any,                 sonoma:        "68589510a49723ed8ce019b3479aa92cb7e610c043943e173e405a465c778adb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec3c5a46ae1057a5e62fc15c16c09bdabf2d6eed4b92a6cac0b32a0ff3e5590d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95fd1c37f5d15b049b43c0ea65c0935432eedf17568ce15e8b71ef1f272b4080"
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
