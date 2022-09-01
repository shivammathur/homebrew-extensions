# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f7d426cca697ed1e064ed7f8f5cd2a0b176aef6c.tar.gz?commit=f7d426cca697ed1e064ed7f8f5cd2a0b176aef6c"
  version "8.2.0"
  sha256 "49010a5a6fc19831190f6b5d02a0616dfd6eb6316e14bb43cc523acb2740d2ba"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 70
    sha256 cellar: :any,                 arm64_monterey: "3a4ce9d86fe07e3ae8087a26f08281241695b99da4ddb1ac7c435524ee24d812"
    sha256 cellar: :any,                 arm64_big_sur:  "3c1262df698618a24b3d234d880171cb7adac89ab6d20f57a925e0559d7c4bc9"
    sha256 cellar: :any,                 monterey:       "c6c0712cdf0d32c533509e80b685e70231460b402a591c7d42885eb05cd1f924"
    sha256 cellar: :any,                 big_sur:        "029280053ae639a586ee409157d1753bd72c4617e69de5f9139f429b8f1b7c5f"
    sha256 cellar: :any,                 catalina:       "29a1d2207bd84510df18eb52e4829b0de46918487b7fd2a468ee2a155315cb3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34bf0ba8c0722ff3fd055a1153454722beb2a3472802580f4671f3041540af32"
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
