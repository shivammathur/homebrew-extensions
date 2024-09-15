# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/df26731c023adff296c73c9e2b7e3267ef89eaac.tar.gz"
  version "7.4.33"
  sha256 "42b04519172f4e4585fd318183c3ae5f5998dee881147583c9174442e926b356"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "53303fed1b30a36e9e199daef32cbc1d2a10b7d5cc557f7f4d14d6276ec78614"
    sha256 cellar: :any,                 arm64_sonoma:   "06987b0bd3387cc92312e86220ad56e6ba363ac4c63e2c364768499c3a96e80d"
    sha256 cellar: :any,                 arm64_ventura:  "25b100237d66601daebd6575c51582df7ccea0ec6b52d38031b3602fb624a772"
    sha256 cellar: :any,                 arm64_monterey: "6395063e2756316f655dbf05a94f50923cc2c3466f48a0183ae6b1ee8588c0fb"
    sha256 cellar: :any,                 ventura:        "a53d926849d51c4aa4be45f0e0b92c4e1663422b766196366ca3b5b4169270cf"
    sha256 cellar: :any,                 monterey:       "b1ad0da9ccab56870243a2a32cb0dfcc968d193a64acfe3586983c1790fd9834"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d4798984554a62108e36d8d4810eac4fd132b96a97b0ef2fe22b53a4469bd02"
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
