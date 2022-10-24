# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/dbedb69f6a1a3308b9ad224c3b8dc300cd0fc428.tar.gz?commit=dbedb69f6a1a3308b9ad224c3b8dc300cd0fc428"
  version "8.2.0"
  sha256 "360c9a3e2a2bce4afc499ba230aeb4332be2503d4072684c1ae7f821b7aa6069"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 78
    sha256 cellar: :any,                 arm64_monterey: "1a24e94517b379d76837d7f1651925b6ce0eaa7f337d33e54346a0277b5ab695"
    sha256 cellar: :any,                 arm64_big_sur:  "ba39dc0608cd0a68b62df6e0624ec0375b7f1fbabdadfb129a8b0008f105edfd"
    sha256 cellar: :any,                 monterey:       "6505185e774ae02ef49b8cc4b42ca284c92f7e25534e378c2e1f2165577806a1"
    sha256 cellar: :any,                 big_sur:        "26d38e2f71371680c28538a8bd54e79a941956610473ba9b5c2fae712bee37c4"
    sha256 cellar: :any,                 catalina:       "e3397cd1300519ee4e115a40d915f44f8bd79434c583be4d077be91c0eb3f383"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f088f10b3d15f729dab588d48d4255022554ec118dc1da761f09e0f01c77d1db"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
