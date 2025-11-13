# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_sequoia: "6bedabfcb051a797a660764263755b792610112fa97791b4f4094834310e36a2"
    sha256 cellar: :any,                 arm64_sonoma:  "27bef8a970a1e8ee5907f1f79913d204fb4f89009bcb86920faa735f25f41d32"
    sha256 cellar: :any,                 sonoma:        "3b00f6e1bedaa282009eccbce144f338bc8c0cadaab7002b6c40b7acb793c71c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "410e39134c13ce8afe3832be39b569fbf348b6655c7f645d315b5ffaad322959"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "272e3441d2888251fe2a9173ba2182d57c25ada08ebc52c6286619c167994888"
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
