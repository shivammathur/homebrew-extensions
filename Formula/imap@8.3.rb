# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.36.tar.xz"
  sha256 "dd54693aa334c5c4d72e9aee96b082c2473750a18a6c1d105789c93a3b1692fd"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "1b19b78db42dfe685a3b8f4697b9c847e3d9544cf4b3604c7ab7a2696a04c6ec"
    sha256 cellar: :any, arm64_tahoe:       "510069335cf40beff66480e1869cd98b5ad4d76311441c3882bd57a52e271808"
    sha256 cellar: :any, arm64_sequoia:     "324aefdd6e09e8c6e8f273ddd09e68f0254cb402651833bd0237c4053566c075"
    sha256 cellar: :any, arm64_linux:       "68510f5be4cb7ebc67f0bde1e98103d129d0743de9e01a0f7d88ebb64002a3f5"
    sha256 cellar: :any, x86_64_linux:      "a59be240cae84ffed6e9ac1c885b5b5ca0cea1686e84bd6fa1485cc0d7fe706d"
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
