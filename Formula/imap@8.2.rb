# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.22.tar.xz"
  sha256 "8566229bc88ad1f4aadc10700ab5fbcec81587c748999d985f11cf3b745462df"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "79ea09b520ff47fc78029d30a3ee4e4496e576b74c2f3fc0669e635eedf18d6d"
    sha256 cellar: :any,                 arm64_ventura:  "e9487efcce9e89622752c52cdecc57a4c0a0b91226aec42db7f607324daa21c0"
    sha256 cellar: :any,                 arm64_monterey: "7b46f239e8663768fe3c98a020dc6d83d8c3bed7515beec7daba2dcc1adef516"
    sha256 cellar: :any,                 ventura:        "8e225623e6a5ed2db30540fce4791c4349d1b5799dcd6303ea364aca6ab74c9a"
    sha256 cellar: :any,                 monterey:       "102cf09e7e5cc40533271b16819776f17a25e45c05cd13529687a6bdb790dea8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e45ebcbb23784467ef8f56a6716a444bf7df1d14160d1e0279b5422d070c5d20"
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
