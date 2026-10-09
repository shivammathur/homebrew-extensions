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
  revision 3
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b36f4d79099300a72767b9f04e041e70f645093f15aa1cbb78e2df11960318b0"
    sha256 cellar: :any, arm64_tahoe:       "0fa7be036ad1ff219ecedc5015c8ae6542218bfde714bd25b47c958bf4d1033d"
    sha256 cellar: :any, arm64_sequoia:     "32394983d0d078df69a188458e2c5b68b73e24da155082e1bff5b752d9a51e81"
    sha256 cellar: :any, arm64_linux:       "750537997f03d7ff21b539cd775f5ec26ce45cbf05397eed463c3a9b4d0c9b79"
    sha256 cellar: :any, x86_64_linux:      "bd2b751383f920c575c31a2293772e6fd1ca8e24af6e2b7e775fba9db4892824"
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
