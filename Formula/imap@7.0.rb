# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a4ea0fdb28141b4ca8c902d7dfceea9b435fae33.tar.gz"
  version "7.0.33"
  sha256 "59e7a3a8c00e063fbc4c1698824751b5ccf6e9432522347073cd8edb0c9ec98e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "b0e44149f3334fdbdf2081f71fd931031aa8b4331c9b6ca4ac09c6d0686d1309"
    sha256 cellar: :any,                 arm64_ventura:  "ea6604b08800ae3c4f4ac875ae83b04c317b76a02acaad065a0b1a8d492553a7"
    sha256 cellar: :any,                 arm64_monterey: "9d72cfdaf0caeab75f36cebd63cef3e560bc7461f65d569d91095d7908708db9"
    sha256 cellar: :any,                 ventura:        "6abe0c5d3e1555074376af02f0980f41d22d8b5fe558f617b0954d0a9f86c58f"
    sha256 cellar: :any,                 monterey:       "6e7c57a000f1e8f64b0b33513e22b7ffaaa3e66cffedcf7b6f16a2c3e28981ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d03d47329b693ff2d06dfd25f111cf15a62eb9abdc2b213b85477d5f415f8e8"
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
