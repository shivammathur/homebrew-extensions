# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.21.tar.xz"
  sha256 "e634a00b0c6a8cd39e840e9fb30b5227b820b7a9ace95b7b001053c1411c4821"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "630b1cb92055d321aad28d5eb79554776f5103334510e2595c697dc0d45316a5"
    sha256 cellar: :any,                 arm64_big_sur:  "972fe4c6de55afac9dc562a3840e74d3225f5ec57bb629e6255046e20e5be149"
    sha256 cellar: :any,                 ventura:        "8b7262ffe33bdbfe04fa6857e0c1beabef8bce9fd57454c751d5846afea081ff"
    sha256 cellar: :any,                 monterey:       "d27c8a4d03562b9beedc7a278a578fde85d2088b7fecc67461b958fbffae3123"
    sha256 cellar: :any,                 big_sur:        "4f593f964e8af9f33d862a5685c39ef665d6623d53bcdd1b8e46caf75b591964"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5896567bfd928349fc1669ea7848f38408d3ad87f29a753941e379f778fcb743"
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
