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
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "b8386ffce25bd1ab6de0754e57c2b1647df1b47ecee31bd4ba1f9c9344d74d9c"
    sha256 cellar: :any,                 arm64_ventura:  "c31730c4b5d01fd7f8cd32373adb071c93b00904bbe7353219a99d368ba6f647"
    sha256 cellar: :any,                 arm64_monterey: "2a0a0916f5322665a129f376c1f9a34a1a4777b365d698de7ee7349584a87b4f"
    sha256 cellar: :any,                 ventura:        "41db036935b0d00d0544fb7b70f33da126a5609c36afff659f6efd5b3b5a07eb"
    sha256 cellar: :any,                 monterey:       "274acad5924ea3efd13f84c2a382f44b1631ed67af07dc85514048d8b87a55bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b15541d68590f3db0659120a2e4ea8d8b3d7037b91026350dc115144c9e66c8"
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
