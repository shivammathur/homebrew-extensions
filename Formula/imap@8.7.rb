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
    sha256 cellar: :any, arm64_golden_gate: "1bca2edcfd283ad7049f8386eaa2571285ba0bc4913a3dc1aec51569f67378d4"
    sha256 cellar: :any, arm64_tahoe:       "a489bcf1b334712443c4b026d87b555f83f9987e7e6db6803ff79dd8e6a9c461"
    sha256 cellar: :any, arm64_sequoia:     "8657a353e426cf7b6c156e61885022adcd1f18a9719b932540b7f22c798f2202"
    sha256 cellar: :any, arm64_linux:       "9aca2965e6aa8bc5691b877f5345caf60a65d8247fcc2bdb25c48c4dc30c9f87"
    sha256 cellar: :any, x86_64_linux:      "ffd46c9dc1de5484864e15a501140ec39f431b608b1d01026229caa3b4fb8bd0"
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
