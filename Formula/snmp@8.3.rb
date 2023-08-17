# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/63a7f225ea638a18c875adcba067e29bf117dd08.tar.gz?commit=63a7f225ea638a18c875adcba067e29bf117dd08"
  version "8.3.0"
  sha256 "f7dd82ed41d8f9a0d16364550264109c709a2fb2897f5835f8bc309e57946b1d"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "70ef0f72e3ab094a7f47f0ce727008501e68af712efb278ae151618b74a40f53"
    sha256 cellar: :any,                 arm64_big_sur:  "493ec5cf5519a9812a95e662af7b56e447f5087c609e40ad10758b7e77efc838"
    sha256 cellar: :any,                 ventura:        "22584e2fd804a74b3657adb8ff5c9086d1fa02efb3f1e3c4a508d182564f39ad"
    sha256 cellar: :any,                 monterey:       "1376ad17a0e0344ac9035f945ba7d3931cac6b5f53db4413bfd0cccba614600b"
    sha256 cellar: :any,                 big_sur:        "78c123781805ddf72c4eb8e7986717dcb59eb46014320d95ae832d0a7628a308"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b79841ecfc10f05ce317500b1aa24916ebc6f9c035518648ea01c86ebd1bc59c"
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
