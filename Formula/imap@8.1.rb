# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  revision 1
  head "https://github.com/php/php-src.git", branch: "PHP-8.1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8ecf3ba72bd2080535730eacfd1e8edc33fad7b0113fe35570d111838e43e116"
    sha256 cellar: :any, arm64_tahoe:       "d6d265fd2f7981c86ff8f40e7a3f3aac3bb45840dca293fd01a95da6de71597d"
    sha256 cellar: :any, arm64_sequoia:     "3236604a653791818ebf55e3633d54082b40a4374f4264984bee03399836d174"
    sha256 cellar: :any, arm64_linux:       "719976f0fb535e981c5361ca4d882b2befdf393b980024df9b00afa4ac89fd1b"
    sha256 cellar: :any, x86_64_linux:      "c900981d82c55caa641b1796dc60093991f6ad1d2750a1391431ab4eafb79937"
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
