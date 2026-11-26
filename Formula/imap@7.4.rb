# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9608f3152844986efc1ce94e9a4a603e252f58de.tar.gz"
  version "7.4.33"
  sha256 "f2c7d3c82fdf553f8f3c5f0dcaf6334b22a4e0d02f36bce64433cd835ec30978"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "2a40eb0854373bbfe9bad5495b7a52b7643bee360c147689da6dc8e39c5de19a"
    sha256 cellar: :any, arm64_golden_gate: "e44435cc71cb24f9829eeafc64c3df98cd3546a26203f031cdf572b9c28187da"
    sha256 cellar: :any, arm64_tahoe:       "5d4c12c8e9c93be1ff90ce92798010c96d1d39fa867843a42b5ee9c681e6f235"
    sha256 cellar: :any, arm64_sequoia:     "6f0a25c5f155bd787b363c03bb82c7fa97f14e2a94b0fa42e9602b694aaca205"
    sha256 cellar: :any, arm64_linux:       "5f77ebe025c9b1f0f9013ba7bbd90e6901eda18dd791072acdd865fa53aefa56"
    sha256 cellar: :any, x86_64_linux:      "d7835c891c112df555f03dacf9b32d378809e9fc2fff06fac21b3ed7afd50427"
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
