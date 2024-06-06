# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9f2f43297dcec5d2f679c2cf336a79bdb816a330.tar.gz"
  version "7.2.34"
  sha256 "4b1d6df7b8ca1b1e1a9bb78e964609728ff772f3620f9c5a479be02b3ff80b47"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "5d4f450d8e883f7de476d3613e2760f19a503e5740a974b540bd55f632568371"
    sha256 cellar: :any,                 arm64_ventura:  "d6808b82cc2959a975ead9674fa4a17a1097dea9f3f9715bfd8933ba416f350e"
    sha256 cellar: :any,                 arm64_monterey: "2378562bcab6ef62c54ecaa32b096da7073a480a4ed18591d2f887660ca4fd49"
    sha256 cellar: :any,                 ventura:        "76e8a76d5f65d68aa7031c2a18cd4891f809e99a0a6b86566f00fee3f7e74f71"
    sha256 cellar: :any,                 monterey:       "2d8e0c4c6f387a2ce7e66420c70b5d47ed6156bd6450399cfc42876db1b73956"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8a4155880206b53fef003e07b1e1be1bc965a6abaf5cbf330eb1f7a87fe307d"
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
