# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0f4f238b1706f5423b9affbe4f58fe6f0a3a6fbd.tar.gz"
  version "7.3.33"
  sha256 "3a2b3d936b47133582d0da6e8afa30be6c47233aa80ffa0affc5013be10a2a50"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "2dc71fc97fc8aa38de790c5110bd16a00a9595a0384cd8bc4f55962791f16e0c"
    sha256 cellar: :any,                 arm64_big_sur:  "8084e3a743f901211f618c3cd9a10c76135510819b8f52ae4ce1fe7b86de6f46"
    sha256 cellar: :any,                 monterey:       "ac23fccea78b59a5e7aba6fa8ca39f37cda54c2ec7bcc2e7b1298bcc32174754"
    sha256 cellar: :any,                 big_sur:        "523807e1c1e15cfc338706632283f8cc121d45063510b8534465e18c7b674821"
    sha256 cellar: :any,                 catalina:       "3856d3a131646ebf6976dddb54cd0561bb376206d6b1f723ea9e591621013e83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a3412e50d842459eecb503784cc852417ffa77e3e791acd083e218d822bbee2"
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
