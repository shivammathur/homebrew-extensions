# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3cd5f2685ba87c1a5804799ef97580a5b38983b5.tar.gz?commit=3cd5f2685ba87c1a5804799ef97580a5b38983b5"
  version "8.2.0"
  sha256 "03bc21661e77227c88b940f4fa5d896e84150d732c6b517b0958232bff2b2cce"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_big_sur: "64d18d60a3ce97f58f7ae021128d19f79c023077b4bffa6ae92ddcb0bad11129"
    sha256 cellar: :any, big_sur:       "e7e356d1d9d36b4b8222944b98d6547daa013ec9cc8fd0b7a5eeac13257345c6"
    sha256 cellar: :any, catalina:      "1a965b025bfce27eb08a18331fdde72a14d8d56539a843f604d5e1291bf9c59f"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
