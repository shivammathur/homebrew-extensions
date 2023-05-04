# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/41cda46b70072f97c63692971291346af0e67a45.tar.gz?commit=41cda46b70072f97c63692971291346af0e67a45"
  version "8.3.0"
  sha256 "bafc1bb415ff3f4ce4229cd7c2692f97e6c44f4396702df296ceb22599ab729f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 32
    sha256 cellar: :any,                 arm64_monterey: "3b109242147a1772e2e81bb6e5ddf4f1628a1644f424b5ed55ee0635c5b200ff"
    sha256 cellar: :any,                 arm64_big_sur:  "1662cc8fbf926283ab22ba73b2753173fad5a06d44bbb45b9c8f9036ce7bff29"
    sha256 cellar: :any,                 ventura:        "e5d5a7a4438ce5c914aa99ccf8b0bc2748a7589809ee29903b9613331f0e0e9d"
    sha256 cellar: :any,                 monterey:       "3c555467c568333b2ca10e75ce0de9d3bedeb642d94804e8ac8f5e60af3ed20f"
    sha256 cellar: :any,                 big_sur:        "df42ef81775ecf41a4092d632e40345f943613f26fc8a9ea74fe98311a023625"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b77721f485fbc3d11b5ac27b4edd4b34217c7ef3754e3f7e4862a4ca0db40a0"
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
