# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT87 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  revision 3
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c977b11011963096f0d0283a138edbfdfdf7387d35ad1f9df483a687fd9897c7"
    sha256 cellar: :any, arm64_tahoe:       "036ecc4249d8f667f05ec7fa850ae603302021f242e583a60de20e57f4e5f964"
    sha256 cellar: :any, arm64_sequoia:     "9497f3de514593d439a137bee005a1d6e7ef0eb9188f48ba42423d666effe7a9"
    sha256 cellar: :any, arm64_linux:       "bfb453ee3416ae6e470826e156c549f0a12a8f5b4ffdcebbf5d7b60caac0f4c7"
    sha256 cellar: :any, x86_64_linux:      "1b4e255d9d693c1e83ae5b8a7be88a9027b0f6ea96082e55fbf319ac20ed240c"
  end

  depends_on "krb5"
  depends_on "openssl@4"
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
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@4")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
