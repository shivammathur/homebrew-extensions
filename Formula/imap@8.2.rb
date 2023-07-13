# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.8.tar.xz"
  sha256 "cfe1055fbcd486de7d3312da6146949aae577365808790af6018205567609801"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "277b2022632f6dff5941a409618176fb750fac8331f346c054396e7563fd529b"
    sha256 cellar: :any,                 arm64_big_sur:  "c4b323e078dc1911f2c8174bcf0824f1aa9d15f2c77537033033cb436811f762"
    sha256 cellar: :any,                 ventura:        "7001a85fb8e5f1862dc4f23fff1aa6dd0b0e3f6f33b2e73c2fd54ab0c2896338"
    sha256 cellar: :any,                 monterey:       "718d5496f14c6b31d4ce239cdc9686c9318b02b57651edc10b7535c9c9d61da4"
    sha256 cellar: :any,                 big_sur:        "00130c1d43a2c1e5b929a18b35374cad7ad6d314fe6b50d457c974966d7f1058"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc4778baf4f1c113e15cd127322dc0453fada521d7059e8f055a5c03946e52c1"
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
