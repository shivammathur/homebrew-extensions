# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.28.tar.xz"
  sha256 "95d0b2e9466108fd750dab5c30a09e5c67f5ad2cb3b1ffb3625a038a755ad080"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "593037584a152f13db3d1499f2f03f18c37b2c81a7b867315ce3500d58fdd258"
    sha256 cellar: :any,                 arm64_ventura:  "dedf4e41ecce243269f4059a3267695051f942d61c4281d4f86bdcbb77434a62"
    sha256 cellar: :any,                 arm64_monterey: "66345eeb51cf84a956b863ce49af3a08c8b798b89f56e6b1781935f601156393"
    sha256 cellar: :any,                 ventura:        "df72a760ab2ff012245c4da5a826b0582ef5dacf194507da209434de20f8401c"
    sha256 cellar: :any,                 monterey:       "0c4f3d82b4e1d7cdb97a2bbd13fce95b558914f78c6f59835b60d3a98270e251"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7ebd3c7674a013bda23172bbc230196f8eed1e17258a8a21df4b8dea52441784"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
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
