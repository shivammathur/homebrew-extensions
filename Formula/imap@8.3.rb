# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.15.tar.xz"
  sha256 "3df5d45637283f759eef8fc3ce03de829ded3e200c3da278936a684955d2f94f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "44d92e2155f5ca69e997a68114f9ad11df3e6d1e8ddbe9334899e2afccf68df8"
    sha256 cellar: :any,                 arm64_sonoma:  "37edc318ee24622032cce6924381843d49e5a554eea8d29b1cf29e2178a5ed0e"
    sha256 cellar: :any,                 arm64_ventura: "a8a2e326b86fe905f11e1fcaab066154a8c456df9ab7308de38e0e21e51faf28"
    sha256 cellar: :any,                 ventura:       "c68fcb0250d4d320884f169e15d27b59b34225345b04f479ea731c4e49b0f5dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cabe9f391904e4db407fb7e65ed5cddd959025b15217ee9c21fc3eb3f89409c"
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
