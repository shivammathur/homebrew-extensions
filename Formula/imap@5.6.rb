# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/cfad01ddc65a32fbde3110a84c61d2ac55173a9c.tar.gz"
  version "5.6.40"
  sha256 "2de08c58b35d061f07f23b9dbb9f64f03aef852a60cd331bd9dd9286e71bf568"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_big_sur: "15e1950fa40068f853bdff683c59e620d03e63072fbdf06278ad65f085e2a9ac"
    sha256 cellar: :any,                 big_sur:       "19424ad42d5b824f624ace04baee83c1e100e2db5a58898852a2d923ed48c8a9"
    sha256 cellar: :any,                 catalina:      "9aa9a50956ff11be7e984f75f8a1716f198f6fb885f6e06f05af86e3a26baa6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cfee797ebd3185c294babd46e29401b2b583fc2d29eec964340dd83ad0cfd240"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
