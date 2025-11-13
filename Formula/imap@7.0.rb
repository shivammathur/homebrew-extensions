# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4de530c8e7f4d5fa3df1d0e15d79a7bd44cc597c.tar.gz"
  version "7.0.33"
  sha256 "3371c5712eae64aa28eda7733a02d93ec298894d57eb0ce3fdac0904bbee4a16"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "6dec186bc33c570898d82ef77b5e11f82564d9e32cd74e5e65e465bb5f267d0b"
    sha256 cellar: :any,                 arm64_sonoma:  "e8c38e3dce36a164d1d15e947983942aedeafb2bfe50196c30733cfa40adea5e"
    sha256 cellar: :any,                 sonoma:        "d37eef21dc44b4f8f210c002e549ccf130887c0317acb282e6c2ae140422eefd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d89cbc4bf5408a85e225449b5db0214b3c2e57405d9001a6c55a8f50943779f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41d5d9983de10be8b3116f54d28a44cddb8d1ed0a2707e7e48171e2fdfecf656"
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
