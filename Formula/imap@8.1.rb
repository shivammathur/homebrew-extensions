# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=0c89edac3a64016c7ce35d2231e2cb889a4cc7ca"
  version "8.1.0"
  sha256 "10b0d3dc07de6c66a214ea839f1e7988f440ecfc26ba9a7a73762f36e98c5e13"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 arm64_big_sur: "4fc3139b8501a8d425b3928f6c904dc42614eb0dc92bab137ff3ccf4dfa05be6"
    sha256 big_sur:       "d740e4939233f20445352203e507228d507f06a7f2249b995e856698b05b687f"
    sha256 catalina:      "0d11ae4dcff917a657ff244c9b93d416aba0603453a60c31af2d7b5c93a4d940"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
