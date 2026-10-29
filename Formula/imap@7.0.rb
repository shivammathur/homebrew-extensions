# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/67a075e9b509891ae7b95e8ff48e73c16f63a19d.tar.gz"
  version "7.0.33"
  sha256 "29b56e2126d94f5f8fa848194fb4073f33c30ce1f484c94dd52f77de668fe850"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "273792fa05d8671323c582a08dcd005a2aa216410a226ced0ee81567d7da668f"
    sha256 cellar: :any, arm64_tahoe:       "aaccb8d9ff444321644407aeab8eef5397df386889eba7ef220bb1823677e121"
    sha256 cellar: :any, arm64_sequoia:     "fdf50883dc6318b3b120f3636cf0ff0bb6522cc24e66c60268b3354424557970"
    sha256 cellar: :any, arm64_linux:       "f4ab932f12724b5a99b3e1474ef6ff57ba5b216bea02688419863cdee4f6ed79"
    sha256 cellar: :any, x86_64_linux:      "caf55e1b0b8f8e2c44cc1de0f931e16baf5a6f230984b1a180bf09a324b108b5"
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
