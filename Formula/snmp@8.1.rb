# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.21.tar.xz"
  sha256 "e634a00b0c6a8cd39e840e9fb30b5227b820b7a9ace95b7b001053c1411c4821"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "039b38e671f1fd5f9a6d4bfae4651432702c75acf1f4183d92ea97880a410698"
    sha256 cellar: :any,                 arm64_big_sur:  "d85ea5749565aac4bb6a5e194a6fd2fe24a540fc8bf4261fd87cb27de1de18cc"
    sha256 cellar: :any,                 ventura:        "15b4231225f30133ff7f28f41d13bfbd0c7f7ce82813e8a55b4d6103d136ab7e"
    sha256 cellar: :any,                 monterey:       "a6d60289e0efbbc4f2105def4669eb980c3c2e0b434756f9d98b3487e20abd7d"
    sha256 cellar: :any,                 big_sur:        "7741a98243a523f53f494156dd430abff189bc541d98ff5ba39985c1fcdea03e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ff7526438e2a064e23e783aacfebcca01b6d5bba2354c8edacd87b0d9d26fb67"
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
