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
    rebuild 34
    sha256 cellar: :any,                 arm64_monterey: "8616ef3cea2ae7aa131f95867e9f3ad9f567322dbb0d8bded83a602ad35cfe3e"
    sha256 cellar: :any,                 arm64_big_sur:  "197042029b7d3b85451d652990b6a98421f43279842171e771c2acbed3ce28a5"
    sha256 cellar: :any,                 ventura:        "51c84295c1a3d6ee339aa2f90332ba83b1e61b3a1b8cb0834f8c87c647fdc1bc"
    sha256 cellar: :any,                 monterey:       "c3ba18e3f93711b3ad5828cf2613fa1bf8cf1845059415333dd54e26b518ef1d"
    sha256 cellar: :any,                 big_sur:        "542ebe608f9eef9f71c94798a0d3990df0528c6fcf037f9b8ddb87e3010d4ea3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d8b57e6268fea9af5c47cb40de28ec817430b111a7d01c91138d710aafc9006"
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
