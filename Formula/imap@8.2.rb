# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9b968ffe1099005069ba4ad3891ad3bd0d480940.tar.gz?commit=9b968ffe1099005069ba4ad3891ad3bd0d480940"
  version "8.2.0"
  sha256 "7cebade3ffab34e125bebdbb8144261a9d91f2a6bb6af797ffcb70481f9b2c8e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_big_sur: "27e261f66b4299738af3fe4fe8d0d9c8881b4cce4b720fdd40e60c483b164fa2"
    sha256 cellar: :any,                 big_sur:       "5950e2b331200eb0bb8691aaf49dcce553f819d2a5df1a16721eea80ea034dfc"
    sha256 cellar: :any,                 catalina:      "4ff03bd5cbfda90b56ef598dd288c3ef6511e2c8dfad3cfb78e873497f0f3eb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b67b3264d491ebbdaf412777823a9469427528b65ad572c7a43f0e78460ffa4"
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
