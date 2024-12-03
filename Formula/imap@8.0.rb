# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e62bf3dbf92627e79283013f6e83f7a4e5ab3e6f.tar.gz"
  sha256 "0ade4ad72b41f3e1c05e001dd3cccb52800eac770f5bbb9472674bc1fa90920d"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "026d363c3118bbbcd78979cf7f651bcf560972a41f8c10aaf5caf33b46dbef9a"
    sha256 cellar: :any,                 arm64_sonoma:  "8471065888f196c77bcb588310037ff07d9e4bc732f2707f9e1db0c8d5388cf4"
    sha256 cellar: :any,                 arm64_ventura: "c40363050bc068b05c412ff406d66bd2613f76be48f4c47614df3dd843877f84"
    sha256 cellar: :any,                 ventura:       "f882f7f0b49aff6dd5f2df13f9997928bf16255528331c0221fa1fb1d03791bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31e437acac6a96546e5be0025e4ce6c81bb8d2d82b6029899ed5a4db8225fe0a"
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
