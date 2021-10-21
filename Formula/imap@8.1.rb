# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/11dd5e6e0869354d34b513ccf5bee4759537a119.tar.gz?commit=11dd5e6e0869354d34b513ccf5bee4759537a119"
  version "8.1.0"
  sha256 "76342f0f28313e3711ca6cf868f9ded7a8b7914c7043ed227aae028b2b1dd483"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 32
    sha256 cellar: :any,                 arm64_big_sur: "a5c0ba4d6a3365e82e2526905210c1d70ab43a5e27ff9aa4ee323c0cbf906a62"
    sha256 cellar: :any,                 big_sur:       "fdd56568feb4a552b098276bbd5a0da493178177793527b67ed7f6007ecc1032"
    sha256 cellar: :any,                 catalina:      "e9aa88107e6a43f1213dcf0560597ce71ab82ef0f707688935883985ca9a072e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1b919b342351ceb1cba063ceb53c2484310f6ca13495993bcbed03112cdbc8f"
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
