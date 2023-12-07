# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e74bf42c8154ac293a16ba3e7e1e811de83ed24a.tar.gz?commit=e74bf42c8154ac293a16ba3e7e1e811de83ed24a"
  version "8.4.0"
  sha256 "7d1dce390099b54fa161aa03e352c8ca0d566d5a3b408dfa2dcc48d9d0d7874f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sonoma:   "4814c6172789d0a6777a159049b88b0ef7d05fe16ff1d7abe58c5333046b7534"
    sha256 cellar: :any,                 arm64_ventura:  "97952ed730e93e234d1b2d9eff8b30ae9d8fad589f2477d01aab97d5aae03170"
    sha256 cellar: :any,                 arm64_monterey: "34e0e9d545d9848532db6bc4725372b4c22cb3917b9483e43c71c01b099f68f7"
    sha256 cellar: :any,                 ventura:        "88253e48aef94c095f29bb408a77f41fdde7b04a6f5d319c93993bc6afb1ac3f"
    sha256 cellar: :any,                 monterey:       "d957bc5834f1220f015dc2a2ae2c9055282920b12d0c96c24f699a3144ac95cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b627ffda75a4fcdccb886ca7ad726afbb878d2346a87689186fa692dbc337d5a"
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
