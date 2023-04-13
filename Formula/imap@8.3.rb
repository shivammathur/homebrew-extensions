# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c796ce5713f21a3de77e710f4028c62f45bc0fff.tar.gz?commit=c796ce5713f21a3de77e710f4028c62f45bc0fff"
  version "8.3.0"
  sha256 "a18ab59f65fe42870f2085fb9ef293bf03a39e7f7021c08f710503e287bbd885"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_monterey: "ef57fd84f2af3581b27c8647e036e9bb71d5745e920a5c87ee1d9b8b68ac1d95"
    sha256 cellar: :any,                 arm64_big_sur:  "7ccdc6d4e1f9193d3adc2b2f54606e1d3cd6a84997811b74401de287b46cc131"
    sha256 cellar: :any,                 monterey:       "391e120378514544e1013f29194c6c458f2653a5dc5b8275bdf20d6d8c688783"
    sha256 cellar: :any,                 big_sur:        "238dc019dcf34a977029403aff53f23a66f748be7a392ef4691c23f79cf8f3fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "265185ee32bda4a459a6de80fed027059785dad15200eab2345a35d7cb868432"
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
