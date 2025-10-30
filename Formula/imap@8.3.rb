# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.27.tar.xz"
  sha256 "c15a09a9d199437144ecfef7d712ec4ca5c6820cf34acc24cc8489dd0cee41ba"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "681e540a5fd8f0165878e4f210993ef8abcd288ddf98cbf4ce42e652a39ff977"
    sha256 cellar: :any,                 arm64_sonoma:  "e89b553fe59a74bea9ef00bc16fa61848e21a53179b068fed589eb7f8136130d"
    sha256 cellar: :any,                 sonoma:        "4673b78c5d50cad05748f7605dff5d42d361a2a03a4b062f82cff4e1df5a8c4a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b3b6f6f833dc168a20480ec9f66fe3f4494252c4eae464445c589051a45e8bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d1f03e63b5e65a72f41aa53d752ddbdb714a0cdb009bb8b470086edcac7dc632"
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
