# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d4ca691b6d9f309b8bf22a55e423d2917f765b8b.tar.gz"
  version "5.6.40"
  sha256 "49dc98dda388ae99e6542b0b6d395c13b58f0b35398b61d0860315e8b1e54988"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "68fc6d8e112fc3f620c603221e2b3c4c3c23850399da43aa342a45bd7883232a"
    sha256 cellar: :any,                 arm64_big_sur:  "0859c060730a51d4f317d155ddc101bd10ac0ec7ab26e91563a723c495368b4d"
    sha256 cellar: :any,                 monterey:       "17eb44944e09f09bcc73a4b10e04d22f89a2ada244fa47a549a98d3822ee66ac"
    sha256 cellar: :any,                 big_sur:        "9389aca2771d332c753f9f982351ab32793eebb85c782cd1f04113caf3d106a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "570bf04628803335c6772e87cb009ad005f8a4baec4968341c148ead17f2c1da"
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
