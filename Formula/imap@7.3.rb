# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7ff6ba7443d4691f7c7a2ca3b8f58f3cea632765.tar.gz"
  version "7.3.33"
  sha256 "6610f090bb89e34257bd22c5bf4081c485fbf53362bb1231d09141017198729e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "0617033e826895f43c7f0906a0ff6332c2a40e209f2def20bb7750ab5fd20cde"
    sha256 cellar: :any,                 arm64_big_sur:  "2647ef26368306940df0a6b67a87ac71ff5486f9ecad6fa8f6bea6e336e03241"
    sha256 cellar: :any,                 ventura:        "35f1b75d512dffea66ce383479deba178944b2ff80cc0075e354b4d4006b8392"
    sha256 cellar: :any,                 monterey:       "9d138434f369e91248e5d3269d15961288150257b44e6c8abd69ce31bdaab99f"
    sha256 cellar: :any,                 big_sur:        "c530ce8ab1b0de40d17a1ca32cbf648c74636d8048a3df3db8df0bf9544fe749"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "07ed3d6afb5e2d0fe3684ee0fee934e79f7e0826915473a54e60739ec618b2d4"
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
