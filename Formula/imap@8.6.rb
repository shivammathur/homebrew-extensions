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
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "492f63e1cca465c37bbe463091e26b9959dd103e6d97a35f6b36fa325626a31b"
    sha256 cellar: :any,                 arm64_sonoma:  "10c9bfc4abdbb2be4ada03b24baa010e8c953b6fef0a4fc704e8c6cb4654cfa7"
    sha256 cellar: :any,                 sonoma:        "47aab867cad73b543b4cfd74ad5dc6174f33c943f17784814dd8aebd8b4529da"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4a3f2e2ef4ac2cc608dd9f2695bc2a2365b5806b1b9617de041c5a2b9bfaa9f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4421f3a8d6c40b9800a51f0d4b57564e711f29c3f611d08d79071122d625dd51"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
    inreplace "php_imap.c", "INI_STR(", "zend_ini_string_literal("
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
