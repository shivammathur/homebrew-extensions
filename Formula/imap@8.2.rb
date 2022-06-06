# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/debd38f8511bcd4f72873f024221af17fca2bf1b.tar.gz?commit=debd38f8511bcd4f72873f024221af17fca2bf1b"
  version "8.2.0"
  sha256 "4d28a051ba1db12d7be03eb73287dbe65e2392f06ea882ca4d7d3f98da0d9bd0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 53
    sha256 cellar: :any,                 arm64_monterey: "63110ca4974796033bce05aa3348004ff0e576eff33a489290bc416e1d7b1cda"
    sha256 cellar: :any,                 arm64_big_sur:  "bd98302e6c0657073a3cd3b4f2c90fc1f0c6f60c5f593c6a70245ccc47c08926"
    sha256 cellar: :any,                 monterey:       "867f3dd97764dde99c559cbef9105819caf17492c836a534c4ad0426181ef30e"
    sha256 cellar: :any,                 big_sur:        "5d245d4b48163faa8e65123141def2501b09ff8eaf68e8d79df3b3a4957a6d0b"
    sha256 cellar: :any,                 catalina:       "f22887fc5275d2e2cdb2783ea6e75c55dcd197719096469155bcc0daa861e050"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c515da46739026b16ee8c52f9071743f84461cc21acf4a3a0b259fc2ad4ba0a4"
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
