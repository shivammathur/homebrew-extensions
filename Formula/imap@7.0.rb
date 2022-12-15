# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4b17f6eac40a9969731963a28476160c833f8a88.tar.gz"
  version "7.0.33"
  sha256 "066be6065d88946b8e27c6703941da124903fca96549d950ab6fd4668f4bbc94"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "1816e799517f6248bebb88305eb769e63a5e5e6607d4cf951d85db64b08e017e"
    sha256 cellar: :any,                 arm64_big_sur:  "26c2795a1ac85cf73f0ec84ca782006a8714949c4ef71b1d8df7d58318f20e52"
    sha256 cellar: :any,                 monterey:       "1d93bf74945de7128becdcee4ede833a7b6298a598b45408edd5468ebd2f176e"
    sha256 cellar: :any,                 big_sur:        "256e718b5d262f83a39a3825284c4bb0fe1aff24ce6bf7968ad103f003a0ec1a"
    sha256 cellar: :any,                 catalina:       "568261a298ae443097d27c78269b95bac6e797533c4473c365599885d06f450a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d67cc12e2ee5edcd64df2271d3a7d6d8b827e574e1456045f877dc53ca3cfd41"
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
