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
    rebuild 33
    sha256 cellar: :any,                 arm64_monterey: "41b1b79c5690030817c9458efc507bf2780110800bd9ae5cbc404f0fd12b4c45"
    sha256 cellar: :any,                 arm64_big_sur:  "426c96cc25451c830964e5d34d90289cba50c66d2d4202a064b654982abffcac"
    sha256 cellar: :any,                 ventura:        "8d0ca3b913203ccd797be4b6dc5c730496d6d57eed17a77aa7b3f46e19cae8e5"
    sha256 cellar: :any,                 monterey:       "443b33cae5eaca5108aa39cbb28802443d93acfd972a092e705edc1fa00e9c91"
    sha256 cellar: :any,                 big_sur:        "6e97c397b66f422eb63b839c008505005cd7251630d663cc49cf064a60c86b46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1220220f6dfa57ef9147ca0342b8b3a3969773108cd14fdc683687c54629b69b"
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
