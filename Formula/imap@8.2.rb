# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.23.tar.xz"
  sha256 "81c5ae6ba44e262a076349ee54a2e468638a4571085d80bff37f6fd308e1d8d5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ef59194b645330657e0a88eb58755b4d2f3094918290a1ee32dbbbf564a0c3a2"
    sha256 cellar: :any,                 arm64_ventura:  "ab4ae2bd54224b1ffdde05f399b9d12df0a9bd29c756db3ba73e6708c3013415"
    sha256 cellar: :any,                 arm64_monterey: "5fb14d9df6879f71c1cade815984d773545d72a8c091336ddf80769ccce1f1b0"
    sha256 cellar: :any,                 ventura:        "5a1dfbd94f6b5324034e7665a03fea58510b393b6385d00769fdf4857b2cda24"
    sha256 cellar: :any,                 monterey:       "3cbeab70e2fcbbc673ca03b7849b00ed35b6df7484d9f20a17dd8aa6b258d8af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "08150883c70b832c59ee3fd89d6533010f5676d7f2de5ab2c2a80ef8e87eba94"
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
