# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/56f916e7033b448857b87e40b90507f6b1a814ca.tar.gz?commit=56f916e7033b448857b87e40b90507f6b1a814ca"
  version "8.3.0"
  sha256 "2848ac065e98ecee8d63d9a8a345fedabbd07432357dbf390baf8631d290e437"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 29
    sha256 cellar: :any,                 arm64_monterey: "2f9c1de5b472862b799898cb05b9e74ea45b3adeb6f100d186807d011bfbad58"
    sha256 cellar: :any,                 arm64_big_sur:  "6f9f885472e82c03ca2032dfb8f865f6479885ae9a78a35d4b68f9e2dfd4c0e0"
    sha256 cellar: :any,                 monterey:       "2f90fa160c4a4917ef403f29f888f0922420aae902eca9515ff49e77e2b2a841"
    sha256 cellar: :any,                 big_sur:        "b68c241d0c4ed1c2aa9ba80410cec2976d57b8f5d4dfaa423d7331b80e4d1c65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be4ea39cd4953aed854fb8d7d45a558e41ed7623eba0aad926a9733d6ba9b87f"
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
