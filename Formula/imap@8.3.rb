# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/06964ab13987c3bdd38c981c87710b8fbebafc5b.tar.gz?commit=06964ab13987c3bdd38c981c87710b8fbebafc5b"
  version "8.3.0"
  sha256 "8df5ef997a76501ee5810f8f089eea2fcbc360b16fe81be3751295f8b5975e88"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sonoma:   "41d9ce29ec449c6ed911801a99e32dcba7eb047c5dd855d9d9dada6831a8989f"
    sha256 cellar: :any,                 arm64_ventura:  "032c30c102a50ca8ba3978ed985da87472aa5588389848f594fb101b14754e9b"
    sha256 cellar: :any,                 arm64_monterey: "8e9cd5203af549c5607deaac9a172f9e992ee285dc4049e9a83d6dc466e7d936"
    sha256 cellar: :any,                 ventura:        "9bc06bab6d72e93f20e59c10f510c8f3e90f9107cceda003c5332b997e627063"
    sha256 cellar: :any,                 monterey:       "def4d05f9ef7d02ad6099536a03c68df3fca5510901e997b7a7c1e4ba3de2651"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8761dce60ccc4238d290f89d7b13765589095ff9df7610c0246e4e05dd6dc870"
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
