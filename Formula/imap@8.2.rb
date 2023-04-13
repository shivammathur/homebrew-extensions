# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.4.tar.xz"
  sha256 "bc7bf4ca7ed0dd17647e3ea870b6f062fcb56b243bfdef3f59ff7f94e96176a8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9ca86681f93a96edfbcb3173232bcc797d84865fc2d420536e42f289d25ccd52"
    sha256 cellar: :any,                 arm64_big_sur:  "24476ff5c030453da5ca74774e3e5fdcb522d0a80fadc94a5f03592b89c4540c"
    sha256 cellar: :any,                 monterey:       "4c371b852e7657f078c71cb943491e2bf063815adf5bdde5269a8c9410703cee"
    sha256 cellar: :any,                 big_sur:        "d867a66f46e65925d1245a60179679bf5d3ecb9dedb7892cce13132328630779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f0348a012ba53f71a6e9ff3b2f09ae21a47f07bfd2b5765a0362968657c5f523"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
