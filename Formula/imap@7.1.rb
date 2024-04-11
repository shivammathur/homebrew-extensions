# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91d880e29357a238394a912121bc48a6225bd7b.tar.gz"
  version "7.1.33"
  sha256 "cdf3ec0af871a5930a9248d8ae28a444262d64a4674e7d8ab9b714eab82f48fb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "af8f2cadc016ce998e4bcd1db13f50274b366623efec49fc46c148e24fe0e7c3"
    sha256 cellar: :any,                 arm64_ventura:  "9c4f5d86b636fe4b16164a5d1803da9db8d3db90033ec832f23abd409006acf5"
    sha256 cellar: :any,                 arm64_monterey: "82c010c2b3d5456074ae67722e5d01223c2dba4ce182e431bcb608b019364ce2"
    sha256 cellar: :any,                 ventura:        "6987bf6901de08dd83083e307714188d2825bc0dc82e249bee24d597e4882042"
    sha256 cellar: :any,                 monterey:       "99b64d057deffda801f69f65c15fdf0fb181bda67b7fc4752e7c02c8676ef3b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ea8d0ea26451757482079c89f3d9ee3045da06d2520a30137b121835e46d714"
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
