# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.15.tar.xz"
  sha256 "cd450fb4ee50488c5bf5f08851f514e5a1cac18c9512234d9e16c3a1d35781a6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4231a038f5e6436b6f8ae6f2fb9215d246bf08160eafd55f47a45afd594d8805"
    sha256 cellar: :any,                 arm64_big_sur:  "d469f8291d524eefd51675955ff65e55416e836a4f343672e12808620435cbef"
    sha256 cellar: :any,                 monterey:       "ada79947f70578101488a119af4587463f36b9f66cf487b0604571ffcda32d29"
    sha256 cellar: :any,                 big_sur:        "3f4dd9ba9455c84d7b5b88f946986882c8552e74f55249330bd3c9071f08a4c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bd6a9ee4fbc79b8e5d41606cc8c79cfdbe671c75b430cefd95e23826f3836f2"
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
