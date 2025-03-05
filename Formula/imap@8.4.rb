# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a5eb458303c78a59bfbc792eaac519127a0920f5932c79db8c41f66e07d6b40b"
    sha256 cellar: :any,                 arm64_sonoma:  "f6826068c16dc505ac3fe35f3fdc5f734e8f7af627cb41cbe83466948bb91725"
    sha256 cellar: :any,                 arm64_ventura: "ddc00db128d2216c01113a854808a51927e63da663724dc0c4827318962d2ff7"
    sha256 cellar: :any,                 ventura:       "28ea6b810d614b36d7b96b41f6b574f59195ea1c9af1e49a60244b87823cdd82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9fe5c5e9cf1a8ec2d5a6e63fc1a5dda07548bb7d925046a8fb08d2701d33cbe"
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
