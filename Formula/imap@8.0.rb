# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhp80Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.2.tar.xz"
  sha256 "84dd6e36f48c3a71ff5dceba375c1f6b34b71d4fa9e06b720780127176468ccc"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 arm64_big_sur: "a059a644f689ea9fe4acb70a4d91ae7ebfb5be7f91cb4e1ed72736920f468d47"
    sha256 big_sur:       "73c146915edde08e0f347277e9ea799f893e94f3b97184a0968fe33ec6e704bf"
    sha256 catalina:      "6881c389cd5cfba531ada6b18340c030dbd19ebea946975e5d012d9541a5b515"
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
