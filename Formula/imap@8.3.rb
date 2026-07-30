# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.33.tar.xz"
  sha256 "e293ed620cec74651bb4a071317892a478aa6840fab22db45c72d77cd42f9676"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_sequoia: "62961377756d982444c4d316f10ac5f2020cbd5c014de6f8146fce1aa02c651c"
    sha256 cellar: :any, arm64_sonoma:  "a10dca4cf1249782f127be9c126dc3d346f5dd6a5fef2bf23d4aea2445f62ae3"
    sha256 cellar: :any, sonoma:        "4a70fda823dfc519afe6f4584b0451b81520e6951d01f87dba9dd52bdaebaea2"
    sha256 cellar: :any, arm64_linux:   "f2197c3d46cfe4e3428d9fd58f3479be57e6e2be104b2b5244bcbe9cb3411d17"
    sha256 cellar: :any, x86_64_linux:  "588d0836e4864b7b9707dc353d71e6fab16b359cdac2d3e574b41a6e2d68056e"
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
