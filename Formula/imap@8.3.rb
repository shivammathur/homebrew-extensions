# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.19.tar.xz"
  sha256 "976e4077dd25bec96b5dfe8938052d243bbd838f95368a204896eff12756545f"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ed434200d645fb891d68d4f0a600870083a4b59669fbb8665b7a02c355c2d134"
    sha256 cellar: :any,                 arm64_sonoma:  "37041557daa7ff58b0da80aa62df9d2a8b92cb78d450cae795b92ec1f8701cd0"
    sha256 cellar: :any,                 arm64_ventura: "02ec1f1916d6c87603e315a5a18f5271a65a2f12acac949e46315709330c9055"
    sha256 cellar: :any,                 ventura:       "400ba0f9a0595094e356642ca9392095d1326cf1309c62fbaf6631e8cec895b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38ae5f2d11f3c4e1513cdd5f4a9b1d2e639fd672fe20bb333f660bfa25742cd5"
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
