# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0513eaaeb6c03e282cf8c13352ca590428bfe127.tar.gz"
  version "7.0.33"
  sha256 "2289f0d30a7be5e556f9ad7804f9f4102abdc40df1d454ecce2fa2cfd0924b71"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "01f7ab6d5892506d8aab3f6368e4a9616f06f49667666e00c9a9c04cc00c2555"
    sha256 cellar: :any,                 arm64_big_sur:  "0782e990fe006bb2c5ace7ae4cab0889b1c79db87ac6b76a3f869a3c81d2544c"
    sha256 cellar: :any,                 ventura:        "d393448ccbc58161cc1b406cc368935cde64e6cf19cbf9a107c560b915631eca"
    sha256 cellar: :any,                 monterey:       "f7eac03d5ce9e52c2f23622bb980ca3150766e25330be405ca9802431503a9c4"
    sha256 cellar: :any,                 big_sur:        "14511c778a9dd798afe961a4445831942d3cdaa31dc1a466ef74c675832728cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "906ec7e4f0437a66c59f0bf33494d118e5f92a33e3144866166ad50fd7a97759"
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
