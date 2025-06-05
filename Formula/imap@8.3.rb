# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.22.tar.xz"
  sha256 "66c86889059bd27ccf460590ca48fcaf3261349cc9bdba2023ac6a265beabf36"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0e6a16e8b71665373e6da9795dd1bbb2ac81bbd2dcf1e4f531fa00afadf50aab"
    sha256 cellar: :any,                 arm64_sonoma:  "baed77c705019a082bcfa89a637d2f9fa7c53a57d9c578a5dee27879da69c94a"
    sha256 cellar: :any,                 arm64_ventura: "97797fbd97e2cb6cf2923b54115245439fc93c80e5e66597d9c19ab541a964e0"
    sha256 cellar: :any,                 ventura:       "d2d6d18a7ec43b572366aa5091c089d07fe7211dd20eba0b4a26f00d6b32f21b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fcfed8b22f38ffe6f270a5fa8dc1dab183bba58597a6a4ac96d3573b623c7b6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbfc358ad8ce75aac775157df03f46a4a7ecc1ac789fdb78cc92ce62f0d74160"
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
