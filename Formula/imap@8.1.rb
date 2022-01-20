# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.2.tar.xz"
  sha256 "6b448242fd360c1a9f265b7263abf3da25d28f2b2b0f5465533b69be51a391dd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "dd0ac4bc9de129cc965890b0831d823ada2aaa3719c34197668792d2aaf21fd8"
    sha256 cellar: :any,                 big_sur:       "91d78cef36f2e078ea1a54f4253fac43a6f9ac7e3457ec1f4a8821ac56f99dd5"
    sha256 cellar: :any,                 catalina:      "d2d5ad0414888ad153f60e5bf7b3866d39e1bce127f872f14477e65b0093dd2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f57003bd8ad4b62da40dcf908b864db91a56e94b9443927d015fe92ee70704b7"
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
