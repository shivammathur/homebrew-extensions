# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c.tar.gz?commit=f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c"
  version "8.3.0"
  sha256 "606158dcf15936552e4660795aa0f4258a3eb0814f2b42b6ec667db0dbe8686f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sonoma:   "8aacb02e7cd67f6a762cfb877c1f353c878b232cf335860464dceb189b50e41d"
    sha256 cellar: :any,                 arm64_ventura:  "44eef6395faede6a34dfc14383291038a68df831fec23a1305185ec821a2805a"
    sha256 cellar: :any,                 arm64_monterey: "dd403d55aa79f768e7e429648bb71989f367fb0f7fbcfc56ecdbceddb651ac15"
    sha256 cellar: :any,                 ventura:        "d1fcfb722244c7b51966079f469321519f39d2f9eb6f76de4a0f20170dbf8a45"
    sha256 cellar: :any,                 monterey:       "3f89eca8ecb0d0be70436750589cfe11bb31f8e7f116225a515af8d0d363e238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d33d9f6a749b50ddcc2efdc50f5490141b15212da6b9053fcae526066a509ad6"
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
