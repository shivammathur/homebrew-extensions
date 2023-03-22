# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.17.tar.xz"
  sha256 "b5c48f95b8e1d8624dd05fc2eab7be13277f9a203ccba97bdca5a1a0fb4a1460"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "10fd13f2af386be3cecd82a67e4b50078d43e3e67bbb6c8cce400b90e2b71a32"
    sha256 cellar: :any,                 arm64_big_sur:  "7b6f4317a87fa3762b9306557326d535b001edf05570dc172918a20933422756"
    sha256 cellar: :any,                 monterey:       "17652c8a32039f689a7b81c6bac530c33e7f6ca2e813b76615433fba38a300eb"
    sha256 cellar: :any,                 big_sur:        "82c78c5ff65da43cc970e4be371e3158c58852b5a31b844d58a5e5cc3a8b77ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6ab5cff96fcc9603322d47ed5b1ded37ebf5e4919e4b7471209e09c0828c7f6"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
