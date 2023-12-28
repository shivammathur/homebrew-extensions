# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/95ef8ca4f13d22de7f23b272c079365069aeae63.tar.gz"
  version "7.0.33"
  sha256 "412db3946a1c2813d46a68d5cd2a6d3a78dca93c0f06fcbe598778159f1e67c1"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "f0c979001ec02aec625dfe961d7e046da586998ff78ebb84a5dbf789ff0031ed"
    sha256 cellar: :any,                 arm64_monterey: "cbcd6b4f31e46bb5765fd0403222b8941763aec5c1c6f5be6cf8fe15605de0f2"
    sha256 cellar: :any,                 arm64_big_sur:  "e647a68d5969b8964dcdcb2e3c60294842d34b596e0850a15e48bdbe9f28cfd4"
    sha256 cellar: :any,                 ventura:        "cb29e0a0ab187e68281e273f252231785a8fa72bc6eb3055b2885a8771697b43"
    sha256 cellar: :any,                 monterey:       "da4886352ea08dd334ad7f9393614235cc9c2facceace9f2747cb6621aa38a3a"
    sha256 cellar: :any,                 big_sur:        "da98ee98f8037de170fa50ca0b1e65c34f49a3647f283da56914d5179e0d1a64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ff793206965f59b7219338ffd042b1608b15ea612ccfd7f0f8555d31c1e0a490"
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
