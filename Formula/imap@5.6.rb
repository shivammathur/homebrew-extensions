# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7b23b9111203a96db10f8da71dccb2285d872d8c.tar.gz"
  version "5.6.40"
  sha256 "f63340f5ed259c1ed1efcc2c935dee875c77f2ffb778bc11ca2572e099108451"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "1f184c4aeacc34f04663e77dda3025ab17a48638c7c4923ec42cad3c10e2028d"
    sha256 cellar: :any,                 arm64_big_sur:  "8100659f85f0f69c8eb37e904af90f0f768fa715f11bed64d33c08ad0cd1879c"
    sha256 cellar: :any,                 ventura:        "51f9bd479b23acb031c1faa277ec2f7ae65d2dc3fe4d21afe660df0a8e00322d"
    sha256 cellar: :any,                 monterey:       "72104c9b5020a4e449f9331f31f9075a4a2a935b06e668fdd846a092e1b3538c"
    sha256 cellar: :any,                 big_sur:        "47223452aa90ab2a8907c69074517e41f147b997feb89751aba477616860b86e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7d22f19d361e5c2df0482146483970728a59cb0a8fadd3bab58cae766e6adff"
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
