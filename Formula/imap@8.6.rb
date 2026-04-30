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
    sha256 cellar: :any,                 arm64_sequoia: "b65d7d93b1f777dbc26c642389be944d9fe8b4d055281bf743ae31ad02c63b54"
    sha256 cellar: :any,                 arm64_sonoma:  "9c7aaffb8e9927fbdad5f44e3feb21857cbf9b7d5bb8efb562a71f5dc8ec06d6"
    sha256 cellar: :any,                 sonoma:        "fe90c36b041d5a22608240e90c2037caddea3faff0174a66ae45d349e7001ae9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c9b48e6635b955bf1756b51619e6dc75ed9ea0d1fc0baa069cae21584dd2be9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4fa393678d3b913cf5ea598b5f9a63248c581329e80441f9b92141ed3c429ea9"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
    inreplace "php_imap.c" do |s|
      s.gsub! "INI_STR(", "zend_ini_string_literal("
      s.gsub! "XtOffsetOf", "offsetof"
      s.sub!(/\A/, "#include <stddef.h>\n")
    end
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
