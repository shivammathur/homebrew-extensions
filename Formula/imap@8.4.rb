# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/55432bfa16c8d45aa255ee4b92038a99022cd24f.tar.gz?commit=55432bfa16c8d45aa255ee4b92038a99022cd24f"
  version "8.4.0"
  sha256 "37df7c55824ccede76caa7ba58ead42a517c16ca2e6ec6d71e094da0de9a01f8"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_ventura:  "d1f988006fb76bf577592fc4159e43965a85d44b81744835929f4821e72b5b1a"
    sha256 cellar: :any,                 arm64_monterey: "ab8f87421bba5a939421f18c23b5899a3f58b1bca62679db3ac3a462a5a8dd37"
    sha256 cellar: :any,                 arm64_big_sur:  "f70a4e4b8483a477399f4de5c4c981988cbbfa65f0407f87235ad607d21c6066"
    sha256 cellar: :any,                 ventura:        "d73885799debe0d61936ae80c16dcf528e31ce583c9fd6bd350b02e900f93852"
    sha256 cellar: :any,                 monterey:       "560e688a3cd9a97d7726069b81f6c99215d20311d964cf851621563e2c8b1283"
    sha256 cellar: :any,                 big_sur:        "e1b2f536b5d6277447a86c773e566889f664dbc93995955411c055be65cb1de7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df2a05da49f603178f73b1d84a9bc873ec6a6be6e6cd5ac868fde5d192deebe6"
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
