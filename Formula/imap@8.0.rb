# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b3988504b443365bfa4881257782b00919a751.tar.gz"
  sha256 "6f0f2a0dbb37e904859d7cc9ac12425434333a5c4b811b674621525430bd5472"
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sequoia: "83db0479e7241ed2216e5fa553f45c56b85207fbae13f148d58ad7c1c3f097ca"
    sha256 cellar: :any,                 arm64_sonoma:  "f3b6fc2ea70f54d720eaf1a7681ecd879e2466e086f1b2047872e2d2cc7405ca"
    sha256 cellar: :any,                 sonoma:        "cd1169469ec3f13d529653f6e280130145eb08cdba8a95f5358d0cce2fbe8c98"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bfbde20669a7cf4249eb3f39a6718a7b085cf299c671299a6781407d70985eca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79bccd4e6c95b8756c1c9003918550aded1c17fc45e1cb8bb9721a4eb824bd0e"
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
