# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.2.tgz"
  sha256 "eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "14f967efd9fdc7777e84c4798f0b205d7cac96c37d1336d14eec6e323fee884f"
    sha256 cellar: :any,                 arm64_sonoma:   "8056515e9d4ccccfdc2c832f2531b8c3a6c96069602ff77f8c23d51383c8293d"
    sha256 cellar: :any,                 arm64_ventura:  "8302f27f9a57dd1d953ed013be650bb76bb2476b4b11228feb883df8a342d4d1"
    sha256 cellar: :any,                 arm64_monterey: "9d44af9a60bdf2e34bb1f9112e7e22fa791638658f20428ddde94f6845b5d2c1"
    sha256 cellar: :any,                 ventura:        "e81e843c9e6d7291069fbe6c93a604ee7da808ba72c71889f43f09a9ee31e71b"
    sha256 cellar: :any,                 monterey:       "d669945b05dcf8eb8f99ca2a61f3fc28e33493ce5982f980a85aef8bb27f181d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d58a63581b2941b6dfdef512e2ad01af283d496a9221660053928524f807546b"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
