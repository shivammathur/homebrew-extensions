# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7cc3c7a8395d963d3129e2d0f473d847f21df13d.tar.gz?commit=7cc3c7a8395d963d3129e2d0f473d847f21df13d"
  version "8.2.0"
  sha256 "87685b0bf67390b4e622b4885baa187be1c4409ce3757063682511baa7d336ed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any, arm64_big_sur: "1f1d2e9ece2bb5c45006ee23519be4e83e57f61cc96624ff23a55985c758f554"
    sha256 cellar: :any, big_sur:       "1b72da9e488249cb635bcaff09cd679b15ef9a48eec5b5bd4bdff51072e656eb"
    sha256 cellar: :any, catalina:      "b325d8935905baa93b68536b1999916265e92ffad45d045c40bd3f3f9a152f19"
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
