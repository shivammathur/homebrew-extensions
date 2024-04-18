# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c05cab383299e9511ac8f198c7a6cac6ab83fa47.tar.gz"
  version "7.3.33"
  sha256 "c8e863df3175b4c3cce46e2e99203b242fcd61a6f6b2749e77f92b9766aa5a0e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "312b401f51d4a5fbebff489fe092f6823343814c6a5aa33de8419f7acd277df3"
    sha256 cellar: :any,                 arm64_ventura:  "6760237e2d986d43eadc06874dc0afed5f6545c25bc26cc555e7216764079bfa"
    sha256 cellar: :any,                 arm64_monterey: "8ed1fa329c0adec15211ed26f4be529e5f4e26f671712c42746001574cf7d312"
    sha256 cellar: :any,                 ventura:        "67de64b3e4b6c3f77e16af0e75673583e12bbcbd898906e716631a38fbaaaa7a"
    sha256 cellar: :any,                 monterey:       "609bcdf5f73e9152bef5b9d2c70c8cb306796865f5f7787cc2364eb7eda1114e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef5a35d8fece3e68c7bbdec8893e0ba5ef51ead73ef338c60f66402a64962408"
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
