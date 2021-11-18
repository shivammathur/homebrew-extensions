# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c032381da0bfb6457aa9cfa7a430790f6eab8178.tar.gz"
  version "7.2.34"
  sha256 "357f57334b1c775b4e9bd446717414dec9e15c3c30a4f3ae61db43ce1273c05f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_big_sur: "bb6cddf4303aa84ef50f9fef913d101b7eff53f875fc1b31781e667ee2f30f1e"
    sha256 cellar: :any,                 big_sur:       "8f13c4b6254bacd157f6a283e8670fcd376a97f8401a1d76100d4b06e02f8e92"
    sha256 cellar: :any,                 catalina:      "659c04cf8b32bac73f2513e2a75e4487cf9a849832f51b91c3c5d44704567331"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36c0bb046e7fe119c0659e628159ae5089d33d59459260fd13e677a13461efb9"
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
