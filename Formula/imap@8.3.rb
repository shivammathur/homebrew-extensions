# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.1.tar.xz"
  sha256 "56445b1771b2ba5b7573453f9e8a9451e2d810b1741a352fa05259733b1e9758"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "7f88e78c564fadb16bec8f591d9787b358063c69649370569225ccf7c30a4fb9"
    sha256 cellar: :any,                 arm64_ventura:  "953761a2b3963be381d945320efb2fbcf8983563b5331073b1676f16f43b505c"
    sha256 cellar: :any,                 arm64_monterey: "597a1c2cf8c4a4c800a91bfd53af4c40221b0ef24e6f3d1431901c5053376629"
    sha256 cellar: :any,                 ventura:        "f57aefe9781878cc0c94e17e28658a6d311abdc29149bfee91766d75d77a2504"
    sha256 cellar: :any,                 monterey:       "fa01d75e1328b92e1beeeff3f3e2202e0f1533f0628bf906fed408d5c5b5e611"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4bc8785ff1ed783c9a058e92fa5e8e0c96a8d635c00c9981048a448f1d60022"
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
