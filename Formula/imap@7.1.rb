# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dc8d6277d12d445642139b8a7c104898a5a80f80.tar.gz"
  version "7.1.33"
  sha256 "3e7a3342f58ca8698635631993a91541d88e7ddf3335e15194d23dafd5bae409"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "746970690cb338fef4573c66084b659bbb1793249527df5129c53d6576796a83"
    sha256 cellar: :any,                 arm64_sonoma:  "15d0e84c081fea02058c2fed9ed5ed9afbe7aaf6765c9821277857c9264e4bf7"
    sha256 cellar: :any,                 arm64_ventura: "15c4247edbf4fa78de3eebb453c7fb84a133c1f8d1a9cc69b48d9ca197333c60"
    sha256 cellar: :any,                 ventura:       "0e98a70282466960689382531b244cf19ea38b503ad6eb2ce10f619e8a829edd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4ddd1a43a9189fdccb0605a512afaad694b334226221d885e91278acb3370ea"
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
