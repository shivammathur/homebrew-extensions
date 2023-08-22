# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/278a57f95a30253d2a462baca43144f4dabad4c6.tar.gz?commit=278a57f95a30253d2a462baca43144f4dabad4c6"
  version "8.3.0"
  sha256 "b766d16e282187fb57827a1d06498ae00ae9243612cc533163d6506f009c32c2"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "fb08e675921167b2590e9f9662db6d7b8129f8b1644d91bcaa723cef9965de4c"
    sha256 cellar: :any,                 arm64_big_sur:  "56d43ecc94ba6242112e076f480403c5dba2da768d5ab65427e952f62779ebe5"
    sha256 cellar: :any,                 ventura:        "aaaca39331cc43467acbacb75f5e36c66020fb056877240bbe1ea90b022678c8"
    sha256 cellar: :any,                 monterey:       "503a9ea0318f62a8e1940316235f6d0257fbea6513487e7f8110a8176ee5a220"
    sha256 cellar: :any,                 big_sur:        "7ba260d1434ba95a238f262a21c88f6f28e9bb4d4eee64ade3a45716060bb115"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b9cf91905dce6e1bc4c2a9359dcc23e0e697b18b9c18017e97a2d9e6600cc5c"
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
