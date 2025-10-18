# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.33.tar.xz"
  sha256 "9db83bf4590375562bc1a10b353cccbcf9fcfc56c58b7c8fb814e6865bb928d1"
  head "https://github.com/php/php-src.git", branch: "PHP-8.1"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2f0e58da5a61e513dea215964a262294e4aaf46a1c7af5cd7a7c351f0612c93f"
    sha256 cellar: :any,                 arm64_sonoma:  "32ae7299f56f16e1eb2e6963cd3cd6f32d2bd31b616446637fbd88503fa30b20"
    sha256 cellar: :any,                 arm64_ventura: "e26c655b1bcce347c35bb485f1d68e85a46ea7b3e5bfcfb0c132e7120f0848fa"
    sha256 cellar: :any,                 ventura:       "d939422424003cf0d288b122a00defc795f1f3530a18215d9a018f2633c33e01"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8009e42f52e54ccdc4c04c88b51e5fe7abc09cc5374b802604575ed422e18dc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f73a8abaf12494afca42c2e837c5fd9225ec2e57f51e0689556e0313c2b1e18"
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
