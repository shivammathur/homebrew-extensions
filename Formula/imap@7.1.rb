# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8c84e4ab015127711d096c461c3ec661dcd8c925.tar.gz"
  version "7.1.33"
  sha256 "4aa6a4d33f4a67fb92f64f7b264b84cd3b81993443bce3b358e1b15acd7e67e4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "540e5d7194a9f5cb1a51b66e0379c3752bd7de14494f32d6d531c7d7309fd2f4"
    sha256 cellar: :any,                 arm64_big_sur:  "bbd5faa08b1ab82a76a1f86ad69ee2baad2f124096c4bce66d7691b8fac4b808"
    sha256 cellar: :any,                 ventura:        "cca114878bff36e3e825889660284a46a52ab6ee13233eacb210805c929f0886"
    sha256 cellar: :any,                 monterey:       "32727461a65e128a698f348c409ee4e45687b601fed4cb5c118c8ef7979273a2"
    sha256 cellar: :any,                 big_sur:        "e490db25342c88c149623ab8b0b83cd613f32481347d9418e3023235c1bafcaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00bf3294f73026a13ab80c12da81805a7948f34d268b624d373b6d118620cfcf"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
