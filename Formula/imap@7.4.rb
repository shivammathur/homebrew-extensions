# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.25.tar.xz"
  sha256 "12a758f1d7fee544387a28d3cf73226f47e3a52fb3049f07fcc37d156d393c0a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c56215a2365876c5435717fd0a88bf99ebe6f29ecb3255bbd03570fe1e1aeb17"
    sha256 cellar: :any,                 big_sur:       "6654dcdb856db0738afe1fe4bc3912fdca8bbb82605a4f9c6c9c6279b9d2c60e"
    sha256 cellar: :any,                 catalina:      "34033ebe8b4d6aa624f680cfe694673a274ed92f82d7e9b42d6155b8401967f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03ac468a3e39ac22fb71eb19c6d5a794d024fe70a9f87a84738b12626d9c8d89"
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
