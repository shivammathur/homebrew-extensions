# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/30e5da4b4bf8604149f19d4f73ff2220da3205aa.tar.gz"
  version "5.6.40"
  sha256 "63619b43de54f884a87f638a41f827c1b978ee3deaa24e0266922f6ce49a78f6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "4e0038a73338ae3766b972c72dfc4c468c4f8f13879454bdaf37060d3415955a"
    sha256 cellar: :any,                 arm64_ventura:  "01a500917aaacf0bafaed2f328104302b003e975694c9cceb5db683a4940475b"
    sha256 cellar: :any,                 arm64_monterey: "220656912661170dbd04b32d47d3610ec8a25f114eb2766429d103578ebbd4a8"
    sha256 cellar: :any,                 ventura:        "2a09c01fe5456e97638bf2f02f02f29cab6c0fe6f75c1f5f3f77f756ab53ac95"
    sha256 cellar: :any,                 monterey:       "07e2c79d469b1579ce9ad1c5dc6c3f11479033cd7e6d3fa78d4e34e62456baef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "714a883c972c1660cedbb3db71cca1d3ef536122af014b8b8667fa1df992686f"
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
