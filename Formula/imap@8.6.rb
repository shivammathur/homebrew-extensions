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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "f0d9edf5ba9869bccd975dade20271bf45bbce0c01f4dd0c0eb534b3722b86e5"
    sha256 cellar: :any,                 arm64_sonoma:  "f6b8370b6511734a1c00cc30cf1f7cc92639de728e1d4372f55e521c405f9461"
    sha256 cellar: :any,                 sonoma:        "223e15397c3f0d465bcb2d7aee1f5a7817eb322d8dc2c53d36439667ff0cfdcb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f4187d83c451f3e303891344021169c736b83d0b699a4fcca4def59b2aeedcc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "428f3fcf2715440ad99e8a33fc1f84fe07ea6ee4f7191004d3390741b3844027"
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
