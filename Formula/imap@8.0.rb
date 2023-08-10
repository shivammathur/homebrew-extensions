# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.30.tar.xz"
  sha256 "216ab305737a5d392107112d618a755dc5df42058226f1670e9db90e77d777d9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8493875c566bcfcf840c2ea62413d1a01e27c8f071587d68d385ad533fae03bc"
    sha256 cellar: :any,                 arm64_big_sur:  "51612940c7866205eeda579352c81ce1594c7807fb9d358d33118d40d43a9752"
    sha256 cellar: :any,                 ventura:        "4d83cb15d66068bef0d674267af3947c71cb68799f7c9ec7f512255afb8aceb2"
    sha256 cellar: :any,                 monterey:       "b413d19aea5cb30e0f577be8d8209b7a20aa0ceacf08d5f893871e2b5afa91c5"
    sha256 cellar: :any,                 big_sur:        "b201dd17d651f1498c8084b682e15056ba8fa1466591d2fc377f9fd36b23e202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b2f138da9af73adc07317a4a995110a2077f2c077dff15af48763601677da77b"
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
