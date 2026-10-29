# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/190a0202b4601d3066088ba913c2f1bda921ad8c.tar.gz"
  sha256 "3b70dac41c775c41913ff3a13c77beeaee375b995f41940e62ace648119c4622"
  revision 1
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "8b610c914fc5ed4a2f5b7921dc89933841767b588799e5ee80a91e91ac6e718c"
    sha256 cellar: :any, arm64_tahoe:       "28a537bf4987abfab1bc9700e9ac31ae4006979dd8f3344b30b816ce570ba191"
    sha256 cellar: :any, arm64_sequoia:     "f6048e1f84713bf4a20335d7bf332c270c6456cecc1ab8bfb9dc814de71eebad"
    sha256 cellar: :any, arm64_linux:       "b3fbf567f381e6c6a6cf90c2fa4cafef0307e01a7c0f5ec784291fec4a50dac0"
    sha256 cellar: :any, x86_64_linux:      "c7873f1789ed1f3442d83740a5c095ad6c96bb35768901c5ea61d08e6ae1380b"
  end

  depends_on "krb5"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@4")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
