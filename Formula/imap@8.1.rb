# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5e39ed08e16fb1ffdf0919d3179b79a2d6390fc0.tar.gz?commit=5e39ed08e16fb1ffdf0919d3179b79a2d6390fc0"
  version "8.1.0"
  sha256 "67fd3941a17edb57481fec432e43c11a08be7b3024542dfed038973d0bff3c5e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 33
    sha256 cellar: :any,                 arm64_big_sur: "7df0e5291334630b349e30f8864363740bbb97230bfced946532754efeaaee16"
    sha256 cellar: :any,                 big_sur:       "b53b3a97e9cbf26bcdc41fe3a497df08c924f7254b8e134a672376dc342dcdd9"
    sha256 cellar: :any,                 catalina:      "c112473082f8a99a5adbe1fbefac2b3cbbf3dc1377b6f1affcc04e92a0762429"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ab22b21c75dbf8ab9b88b1ec9eff1f44877bf2497722d2cf4f829f77bb404d9"
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
