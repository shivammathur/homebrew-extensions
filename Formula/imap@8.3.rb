# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.0.tar.xz"
  sha256 "1db84fec57125aa93638b51bb2b15103e12ac196e2f960f0d124275b2687ea54"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_sonoma:   "ceda1b07c93ea3b146986849be9ab126ba6d2bf66e66e303d2a3e516a88b03b8"
    sha256 cellar: :any,                 arm64_ventura:  "25e7149e93c6706b5afc871e78c53ec2d6f5c2c59917130e36f5893e7e29459e"
    sha256 cellar: :any,                 arm64_monterey: "90163a0404d3a98fa683a273e7e02f4d732ff1721a6a5e162d1c372987acd367"
    sha256 cellar: :any,                 ventura:        "4e5805f677559074a47c434d1fa6e977c549e07c2ddbce23560cbdc7b7ce4b94"
    sha256 cellar: :any,                 monterey:       "a596bb13ae75ffbc15c22a06b0acc1b272ab65a0f215740a5720f8ee0e3848ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "25135d45ee5b86be5def1b9e8e002f2e43b8645724e97a83fb50d80930133e6b"
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
