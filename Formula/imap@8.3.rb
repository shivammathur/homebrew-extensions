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
    sha256 cellar: :any,                 arm64_sequoia: "de75ac40a07b540c03fa0027abecd751dd3463388c17905dc8f9f0d21d3c702b"
    sha256 cellar: :any,                 arm64_sonoma:  "608dcc6b6f0e564f18c120466768fdb2d94241361d41e78c7881cb54bd07b6a3"
    sha256 cellar: :any,                 arm64_ventura: "829f555c4e37a69a6a3978a825e21015da18f3a1a6a534705c660110202d843c"
    sha256 cellar: :any,                 ventura:       "a4106e95e90f9cd63d63e965f2ecf692faf30bcec04a26fc8c6f27504d7de366"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30b558710547ba0ecb85664cd6c27bf6555564a99ce001538b827f5cdcd10e57"
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
