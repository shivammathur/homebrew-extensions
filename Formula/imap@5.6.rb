# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/30e5da4b4bf8604149f19d4f73ff2220da3205aa.tar.gz"
  version "5.6.40"
  sha256 "63619b43de54f884a87f638a41f827c1b978ee3deaa24e0266922f6ce49a78f6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sonoma:   "df274292627336c32c10ce2a068dc3d62a4cd38dd35de888a9cc358c21675c17"
    sha256 cellar: :any,                 arm64_ventura:  "7e46ba320b86dbf66bba245e62c196ba2cc02d3fe1a48edaf9cab014b3ed19df"
    sha256 cellar: :any,                 arm64_monterey: "585163a8259614adff09f24d04ab4fa14773fe74a8db290d3a505e44776cb783"
    sha256 cellar: :any,                 ventura:        "c4d26d4b4e1549cc32bd70e5e210d6f66b5028895a42a69860635a8570fead37"
    sha256 cellar: :any,                 monterey:       "81a031e2a8e17ce3729137161ab56071b0f829477a763b110b7054f8b1634caa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14278d9ea7f71383918024446264620d07dd2fc57d1be8ed8fe3d15a8e533285"
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
