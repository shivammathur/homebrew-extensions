# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.9.tar.xz"
  sha256 "53477e73e6254dc942b68913a58d815ffdbf6946baf61a1f8ef854de524c27bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "411a82a2001c9ed8787aa6442bdeaf7af0fb8d0b3551d4cc617d163ff09d1ba1"
    sha256 cellar: :any,                 arm64_big_sur:  "1a8eaf5bfa1e8ede6d53cf95b7e615fba2788168ca1cefea0cc8b27c3ac9f24b"
    sha256 cellar: :any,                 monterey:       "b36d688d850340a93af1f8790a489a3e54a68a653dd7f4111a48c36e6548b122"
    sha256 cellar: :any,                 big_sur:        "c9a6fd672f43bd543e755e3bb0069b5741094eb99c95d8b33b4e7ca85054583c"
    sha256 cellar: :any,                 catalina:       "434f46ceb457c7ed2e81d2b53610ae467ad91782290130833b61e945699cc768"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74d7782d3e8522ab21f2fc936aadd1a70b91224c794ca16e0e0f1a63d398b5f1"
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
