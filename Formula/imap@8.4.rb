# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.2.tgz"
  sha256 "eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "f5fd6eaf1875f394ca818e24660e5a502d69d00f2b8baaed1cea377cb5de33e8"
    sha256 cellar: :any,                 arm64_ventura:  "6e84b7c203ccbd75a5f7b36caf00246c7590a7b9645fc06da2b9a4f495645fc7"
    sha256 cellar: :any,                 arm64_monterey: "babf53729092c1f8db3b4a5f2bbc1878f3ed257f797ef4ac17c141f060104a8d"
    sha256 cellar: :any,                 ventura:        "b34be31452ed25f7b9b067a55059026fd52a8304a8ab909926b7dbd0ae11aacb"
    sha256 cellar: :any,                 monterey:       "a3f53a60dde08b94f275406d335d7d81c9c2e82d7a0f06a28198e8877ee167ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3375dd5deaf8a5898920b9b3ce451c9c39811ce395c97e6eceb2db0a4772eea2"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
