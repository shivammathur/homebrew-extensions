# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bd03c0343e7df2e70fedf872eea6eb855f3b76e4.tar.gz?commit=bd03c0343e7df2e70fedf872eea6eb855f3b76e4"
  version "8.3.0"
  sha256 "705000a8f0458154117599d6f769a70045dc028693b2b7f543d06490bde4f4b5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 35
    sha256 cellar: :any,                 arm64_monterey: "4644cb5fb62aab14f54098bb22ea744044e17048dd590716ed5afb95f3a0bba3"
    sha256 cellar: :any,                 arm64_big_sur:  "b59680cc7016041634892f2cfd18793aa56279ef209f4676c6e4507005ef0a28"
    sha256 cellar: :any,                 ventura:        "80ea7bd4a197ae72de2ee66fd096d1615dcc1e24d5a5371b70bf604f73135f60"
    sha256 cellar: :any,                 monterey:       "ad0f2569e0d162ebfcf248b20e51dd072c5e89dd8b4771733669454ad1a61c2a"
    sha256 cellar: :any,                 big_sur:        "ac2317d9fe8ece0e6a7c69b28392acf9460d7bba8d7b344b226e76ed830af9ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3425134da8eb9c798dbbae7068edb06bf05b37357abc5ff7bb1cec9e3e14bb14"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
