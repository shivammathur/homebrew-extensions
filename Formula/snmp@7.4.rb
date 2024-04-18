# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c6a5368db2d850e10899d237032dd4d7d116c1f0.tar.gz"
  version "7.4.33"
  sha256 "fd61fe2c759e485aedb011cc87ceb8e159dce63662dd4aded0d6aeb9231edcd8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "49670e25c54baec8379bf1593cd7e93bf2888a0dbc68672a2bba815681dcb0de"
    sha256 cellar: :any,                 arm64_ventura:  "ee37b58e36222d0d5a8c05117d67bf5a014ac8e45184d3e56730da151642621b"
    sha256 cellar: :any,                 arm64_monterey: "e759ce1e99fd62c7ab4d39957c05d9b2c4052c6d8f1ab064ea6cb4537e86afbf"
    sha256 cellar: :any,                 ventura:        "4728930afecb9afdf18718278a30320a23999dc0ab2257be16b67929b887242f"
    sha256 cellar: :any,                 monterey:       "d1a809548f5461bd830c832b3dfcc330251b0408e769f3e62abba5e3ffbf419c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "28f4f1fabf538ba8ca78707c3a0f7a196ac97389cf81ecb63e6268e8c2d67051"
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
