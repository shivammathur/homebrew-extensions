# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/269a597ce7d22198bca3745157a45783d86da7ac.tar.gz"
  version "7.2.34"
  sha256 "01e8a6bf83a7b5e77ec6b02d5933e12a39911a4f34bfa572d99ac0020c9513b0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "3dcfa2ae2b67fd963a13ae1fdc880fe63c602b4b0e1cb6571e3e8659180ca857"
    sha256 cellar: :any,                 arm64_sonoma:  "8108f16f1357dc4a8672f5b2d82ef4aded25e0366d9543b757fb8e2f330588d1"
    sha256 cellar: :any,                 arm64_ventura: "29a9f8d59a38714fe81272dd617c6ef5472771932a694292a92b3a0c7014e5a2"
    sha256 cellar: :any,                 ventura:       "38509ca6e6f5f5096c010228e853d857a429917ffa6122ac44f65bf7f413d6b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "17c70eef9a9752621113c41bba53fae9347a9e9596de3672e2ddd3b19f3823ec"
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
