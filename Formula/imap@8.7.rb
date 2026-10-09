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
  revision 1
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "f86b7ada169427c15bbda13cf218623ac5cf2ed001c6b595d523cf5737a3b0cd"
    sha256 cellar: :any, arm64_tahoe:       "d91c4caece710e19390a42de647530155630716485d7efbd1d0001f69609d02e"
    sha256 cellar: :any, arm64_sequoia:     "78d969ce156b360033c0cdccd719c1a2ed2b1e099a53bdd4f53088c6587641e7"
    sha256 cellar: :any, arm64_linux:       "4161a183492cd4d8deb7fa1778ba05d16bc52b92ccc66feed7b4332a224bbb9c"
    sha256 cellar: :any, x86_64_linux:      "d08dd409f0ab1f3dea51a0e8e87c381f4333b16508818957fb7fc36576c30324"
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
