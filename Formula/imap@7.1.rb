# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f77964ef49a459f67561517cd77292ec505a03f7.tar.gz"
  version "7.1.33"
  sha256 "f4e0826d2fe16ae4dc9d6b7b54a0c24488fb1b66c8202f8a0c27987a9172ec61"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "cc32dfd6b202ab0ce4361daa6eeaf9927db9fce098c0c7c28da1d97874a1d88e"
    sha256 cellar: :any,                 arm64_ventura:  "281f3ae11cb7ce54967098a3fa2708b5a6c84db713af059bc25cb0989fb92aa1"
    sha256 cellar: :any,                 arm64_monterey: "7141cef0b425310142eaf7b81dcfd4df472d99d2456469ada3beb153c10a4bde"
    sha256 cellar: :any,                 ventura:        "9ac9ed151af34e6a36c6fce5fac552e1f538ae1ff690badb8dc51efe783f9e37"
    sha256 cellar: :any,                 monterey:       "ccf015b1c7abe843378424027b273b9bf80b60dfbb4d18c107ea7706d7f61185"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13e354be279a4425ba4ce90c4b4ae3196214dd8f3958b291323fca511e065ea2"
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
