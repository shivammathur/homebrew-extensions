# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d453a327e0075c7a8c5ae8cad75bfcddef2b1289.tar.gz"
  version "7.2.34"
  sha256 "f173b9213c19f3d88bf674318da7e956c25b2591129380270aaeed674cb9b55b"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "e0a20ed9bb70a08ca929d0ce39d7379b54bf7c0fb137bb845cbaa3eca25721dd"
    sha256 cellar: :any,                 arm64_big_sur:  "d3cae19a803bf3276e93943b9f7474e9c9cd7c91296f282077bbbc08fcfc3ddf"
    sha256 cellar: :any,                 ventura:        "9dd38fa48ac1f64e8d9ff816678b8d1bed01f96ffb1017754f02fa1f2f6d1f30"
    sha256 cellar: :any,                 monterey:       "3ab7d7f6ec11f990064a603124cd6d543afec96b477edc0a213f7b20db351b36"
    sha256 cellar: :any,                 big_sur:        "68e9f348000161075db13b335e6541b47b72a388b82131156dddf247b4490c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb1b42c82cc5ca8a7f770c775336a56b2a2cd65a16410126946d52d95b48bf63"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
