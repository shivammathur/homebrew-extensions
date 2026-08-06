# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a576d8eb53e44aff3af9259cfd29e599f604471.tar.gz"
  version "7.4.33"
  sha256 "d82887f2166e8526ea9b1cfd8c5ecf5649718f0b6e341380d333eba8066429a4"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any, arm64_sequoia: "85b3092b41801a8a4c3d888d2d2a8b8db24e6ce5b0de882a954271a94c41c5fa"
    sha256 cellar: :any, arm64_sonoma:  "a65a9d0c8bdd5b406b1d8b989c793cb8a1ebbac83f75a1992999e3a8dcc8609e"
    sha256 cellar: :any, sonoma:        "3beef4cc940f6f6a91a13dd6b6eb6fdf979ef7d64f9397302eb6e51ec5f49f0f"
    sha256 cellar: :any, arm64_linux:   "c72e9091d0005253b3ed7e808d8387f447be9631f8637e6ef0d7c766a04afa1b"
    sha256 cellar: :any, x86_64_linux:  "e43f75d2952ccf0a2a29b066deae4bd4197e2dc704e339f8f941d2f31bde0e01"
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
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
