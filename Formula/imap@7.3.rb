# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bc9eff539cbcaac98720ab7e8eb73dd5bdffe12c.tar.gz"
  version "7.3.33"
  sha256 "83434d34cfeb96c31010fc9e3fdd0e4f67cb3844bf2dffd760afb53270aae286"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "80e5016605ddd20ef0fb344039ef4f0f2d38468946edcaccd64f0af892b5b6b0"
    sha256 cellar: :any,                 arm64_ventura:  "53078e406164e3584b77e59ae15669589c1622e934a131c1bddb0bc46d8264f9"
    sha256 cellar: :any,                 arm64_monterey: "c62c2786f30d07adbb42505032d853b4db70caacf3c87603f85f0f58ad4e4b53"
    sha256 cellar: :any,                 ventura:        "ea08a6304574a6aaf2e548443fdb4ca81dac8ea012806bbfc3cd94dc5fceb708"
    sha256 cellar: :any,                 monterey:       "c74154487fe1200a1ce7931ae4467d59fbeee56320241b69ba7d4685dc07906a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92ae2d345004a4f6e523174dc52df309a6ed96b1a1142959091389e9d9c5dc0c"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
