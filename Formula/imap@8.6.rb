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
    sha256 cellar: :any,                 arm64_sequoia: "cbd543b2e20baaf91d3b78f0d25ae29f37600f847c9623f49017a8a7e76ad248"
    sha256 cellar: :any,                 arm64_sonoma:  "d21a0d7e4b89e41a69c2fc30159f82d974ad3df8f132282e712422db255bfba0"
    sha256 cellar: :any,                 sonoma:        "d5c73f8541700b0d35a5f9c09e6f5c9527e6787e601f88777c81c65111b6ef5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "91f3b18f4e91fd011b842cd72063082de72c12a7de312d2fde24ce14b11bdaaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3add3ff71d88e69c68c3795ed12ae687d119f65e8288a13297107215c747197"
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
