# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.6.tar.xz"
  sha256 "53c8386b2123af97626d3438b3e4058e0c5914cb74b048a6676c57ac647f5eae"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d03989e5d0dcc81da5bfb91284583406c108d72306460d28a7c6626c4b7237c1"
    sha256 cellar: :any,                 arm64_ventura:  "a482970dedbfa4605f6d591ca98739c6aba894a620a94fcbebc2305b3e087c2a"
    sha256 cellar: :any,                 arm64_monterey: "d6caa49a6328f5f1ec01520a18bfc5fa3f9affc2e2949668d011f19cc854aeca"
    sha256 cellar: :any,                 ventura:        "c779574a630b78aa6f59879dffbe087a6f0e3f66ff182dfcdb355416ad4bb971"
    sha256 cellar: :any,                 monterey:       "3450a3eaf7856127f05c9c8d2f5d41697e703c3f7f3827683f0da18d92d952ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ecfdafb514e1f070554641690c2f5d4e15c8e5db8b9398df5dd35e390aef074d"
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
