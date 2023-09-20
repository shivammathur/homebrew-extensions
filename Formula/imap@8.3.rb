# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1bed209363900facb44674e76cf29fb681e48ed7.tar.gz?commit=1bed209363900facb44674e76cf29fb681e48ed7"
  version "8.3.0"
  sha256 "230c13505384d04072eadc06f607ec5fe31639c9deb7c908b7524535c738e24f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_monterey: "01d30f1a93aabee21aa57d166c21d58e902381e0cc0bdac36fff4867ad7583a0"
    sha256 cellar: :any,                 arm64_big_sur:  "30951bab2c5a8ff4ddb9629ab584238400850f0f1c78c710d4ccf5fbcc13bcc9"
    sha256 cellar: :any,                 ventura:        "32383e210bc3f7f45264d8930db5f3aeb04c151c5e3f5242cb03709d23ace683"
    sha256 cellar: :any,                 monterey:       "b555cfa8e56aa5a656f3f656637a43236177efb2fae81ee034cdc35ea308bc7c"
    sha256 cellar: :any,                 big_sur:        "1fc3ec3f99e72e98cc01680b60703d8c4a5f6022a38866a15cad7b4b807568bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a285916a30db93b5dbc0cb215fd225b5a34dec1c0115f81b1a918d75247ee4ac"
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
