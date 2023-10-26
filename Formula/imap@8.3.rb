# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a64b48ba92182136dfa13ff944bc0942b97d5977.tar.gz?commit=a64b48ba92182136dfa13ff944bc0942b97d5977"
  version "8.3.0"
  sha256 "d9bdebea514a5f07a894c2edeba4bdeeec6231cfb7f891e62081983ce1a1218d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sonoma:   "bf415350629d2ee6910bd33e30a914fc06d7b589792fbf429d766e9df3b67821"
    sha256 cellar: :any,                 arm64_ventura:  "fd3a819086be263f8ecd3f6ae763a9afdc151e06f7cd7cbd84e4952a06a5f668"
    sha256 cellar: :any,                 arm64_monterey: "dbb003dca20aa50e1ee0f5aa92a2d3e62d0460fffa732560d0acd00f29fab8dd"
    sha256 cellar: :any,                 ventura:        "8d0ef057c1f1918638afbeda0b05fd55eda13591ae1cc2f3f5bcd3b34f99081b"
    sha256 cellar: :any,                 monterey:       "ec4f38962279abc36985e598709b156214d1afa434f87179e61d5278e0a2f437"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ed1f65750ddcdac15686b63aa2623299979bd93c553ad7976274d390b9903678"
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
