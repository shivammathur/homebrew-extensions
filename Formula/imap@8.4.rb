# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3a4091c388f75e89b9f6b163dfd30d8760b2ab11.tar.gz?commit=3a4091c388f75e89b9f6b163dfd30d8760b2ab11"
  version "8.4.0"
  sha256 "3a45c1935c119fee34781a0c2aa43407020e940c09a78d547bc7f665835197eb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "91fd559c1e02da9b0a2b1e79303f7367307b565c11ea6612890d6546e8ce189e"
    sha256 cellar: :any,                 arm64_ventura:  "7b67351bb5c9cd46d1f61a15eea5d10ee29a6bb1da0430802a73432823dd20f3"
    sha256 cellar: :any,                 arm64_monterey: "e0c40c5a2c823abfade3e923e1043548c94742c08a2d361265b23aeabbbc87d8"
    sha256 cellar: :any,                 ventura:        "3aff8b0d7e0eb557f1de0418e5f5c62ce3c14c7e8cc29add864b480fafad1916"
    sha256 cellar: :any,                 monterey:       "bc6ac6f181f16ea6bb1928ab155a13c6c4b7f328b4c4a5df098e4f1488d28965"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21a4388ba5c903bd19528b9fec75786ac6d01d7f76381bbfc74a216d50a40fed"
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
