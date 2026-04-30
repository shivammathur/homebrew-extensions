# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT86 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  revision 1
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "fa9c618fd5e7d8a57f5b03a7b6300e1a11e4653755992c5b01c57379f93a1b2f"
    sha256 cellar: :any,                 arm64_sonoma:  "723becec7b392f7dabb43cfe3ad62d18d6b99b10f06a0d0015da889fdc0d99e1"
    sha256 cellar: :any,                 sonoma:        "027c4b063db4d6bb4b7218f69c74fa857c57fc60a2f8e5bab83682983eeb1a59"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f8d3b743a5a961fe0598658185a63aa1c79ec7f6f34b53aece2e24425a6b878f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4576ee1c714d3d41d1711274ae90e8d02e53afa86d4c8ccc505a03b3b615df9"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
    inreplace "php_imap.c", "INI_STR(", "zend_ini_string_literal("
    inreplace "php_imap.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
