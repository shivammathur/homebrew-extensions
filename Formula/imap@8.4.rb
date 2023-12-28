# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3f82da0a4e043d19d451abc2f26674eeaa111665.tar.gz?commit=3f82da0a4e043d19d451abc2f26674eeaa111665"
  version "8.4.0"
  sha256 "6d92fd808e76d321c7d01a7e0b613f65dd3a14025272034bfc806d4c2908f5d0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sonoma:   "ff8cbd1a36b6567d8014ca069edc3a950d9e8a3f08b1411cde4f7c97b6086ff6"
    sha256 cellar: :any,                 arm64_ventura:  "0d85bc4a13054b78a750ea81778b0916680d17d1c356e87f00dcd93138647300"
    sha256 cellar: :any,                 arm64_monterey: "643984fab9add046234bcfec3817456db66614ae2176790ca530880a2d0fe59c"
    sha256 cellar: :any,                 ventura:        "9cd44050cfad4ef66ae5b14ed4136e4b0ee81bbec5abde285da86d7d47994dca"
    sha256 cellar: :any,                 monterey:       "2911dfbccada671e221339d0e9c5846d8d55368f6595ffbe2d013763f4af8648"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6658bf1b810a65c2b0a143f613ff2116d286dbb75d9f05d82649f435c59c01b5"
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
