# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5d980694564c11e08e8f14fdb325265ce9d33d60.tar.gz?commit=5d980694564c11e08e8f14fdb325265ce9d33d60"
  version "8.4.0"
  sha256 "9efd2ff1f0b424e0ed92559bb68864e830e1327182e421928c3ce2cfdb1b08a0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sonoma:   "c5ae654e3ee25866e5caf30ad2491c299b5815135d7203e345b7ebc2e3da20a7"
    sha256 cellar: :any,                 arm64_ventura:  "493a3eb738a0befb864703d9c540c6fc2af693948ff9cc0fb2ed1cc91d410e37"
    sha256 cellar: :any,                 arm64_monterey: "b90bb31ed8a6324f5c913af12a9682fc682ae8441230da93419384267fcf8bc2"
    sha256 cellar: :any,                 ventura:        "52cfc92fa86a57855bdeb00426b4f54c2156661c432bde1f77960e3832c730d3"
    sha256 cellar: :any,                 monterey:       "bdd8e82001401c5142b5233b0f640a359010280075e36a655e4893cacb45d279"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "afd0ac7514ec96d6a99bb0507088558e51f82477703ab7803e1b3e96fc5867e5"
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
