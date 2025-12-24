# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4ab83a550530c864e4bef29b054f81f71874d8be.tar.gz"
  version "7.4.33"
  sha256 "1593ea9ebe9902aa1dcc5651e62de5cd38b67ac636e0e166110215592ab1f820"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sequoia: "25f025a91896175d095d45852b631373534716654e65368897260a9b16d3cf59"
    sha256 cellar: :any,                 arm64_sonoma:  "244bf3fafeb8f300698cd6e4a8d9a309db61713dc2f42591d5077ec6ceba309c"
    sha256 cellar: :any,                 sonoma:        "ccb5042a5d30e59ef7f864888497de24b84da0ba6f181bb4953b4a25832d6e8e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "235b1bf92aaa1e31d848e52e20b1706b8922bd6868451f6b75682965bc30c403"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "96b3acc27e40d3564b1e5df0f69e195fa530a431d7f63a6171268461151dadc2"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
