# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.30.tar.xz"
  sha256 "67f084d36852daab6809561a7c8023d130ca07fc6af8fb040684dd1414934d48"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b068da3774fd12f82ed7c561127219ef7121a54fe8108dd30732f1df06c704d8"
    sha256 cellar: :any,                 arm64_sonoma:  "af34ba6ae9ebdeb74db6455c8a3f3909e349aeef2f8a424252c94ce73ea46fc6"
    sha256 cellar: :any,                 sonoma:        "788d1fa79f79060a7fe2766de064e3700c1d28b3a1914ac7baba69f7a7d815b8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "92c259394baef2212acd6ebcb7f227abe87716624d9dc135a161c672b99e8c23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0b46260a2332355da40db7182d8b687d2a96115e1319bff62dd3a32b975d82e"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
