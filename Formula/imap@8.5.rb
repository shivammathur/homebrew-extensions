# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT85 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "cd2fd105750c9dd24cc2e45d1725f264f0bf2c151e0ac30e5d970a30ec80c5d8"
    sha256 cellar: :any,                 arm64_sonoma:  "50d20411d85fca7b331de1c1344dcc476e20afeb86444f7478061dfff8f14a17"
    sha256 cellar: :any,                 sonoma:        "c8400959a794c246747de3c49ce33d556e833c1cf2f77ba9882c3bb405abcffa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5faccaa31583b6f414bd767d96c8c48f7723e5a6b20caf058852f8a05b567b3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88cce2d1c919b16708f2cd4caf2cc13ab951e6410cc017719fb2c14e8bc5bce4"
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
