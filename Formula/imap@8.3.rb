# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.25.tar.xz"
  sha256 "187b61bb795015adacf53f8c55b44414a63777ec19a776b75fb88614506c0d37"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "bd8df915890eeb8f514eb6118143094432fe698f0f284658d3958201facb0e6b"
    sha256 cellar: :any,                 arm64_sonoma:  "1c281634a3d2f2d757cf54aa18ae7dde3cc05ab940e3db9bd4475cc597d555be"
    sha256 cellar: :any,                 arm64_ventura: "af5ea1538d1fbd0ac208963f564c7f236b996e93411f90dcfc8aac0a6989da62"
    sha256 cellar: :any,                 ventura:       "e02c7a9bd903313d9dc569d06d1e2ca8ecfa4cf70936e1feb5f0db8cdf0cf646"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "deaf11a2f0a1dab57392a7dd2c716a327fcf77e0d3771068d3817364e1eacb0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db0790bc0867e0a60f1a7c505a76e23fc0607b5356142f642d4f26f55c55228d"
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
