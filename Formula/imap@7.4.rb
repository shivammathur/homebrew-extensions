# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/df26731c023adff296c73c9e2b7e3267ef89eaac.tar.gz"
  version "7.4.33"
  sha256 "42b04519172f4e4585fd318183c3ae5f5998dee881147583c9174442e926b356"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "367f41c2f5d748cc83074ca918ac60aeb3fc0c76157fd1b69c9c760f7b20aa30"
    sha256 cellar: :any,                 arm64_ventura:  "5ce85b7de774beb861580d1d9d0eaf0369c0ac61373a8f2c460a2a66e423d8f1"
    sha256 cellar: :any,                 arm64_monterey: "408741ced7657b830c13c3dd86e1ef2f047e45bab2b86eb250a0ac882e7f7fbb"
    sha256 cellar: :any,                 ventura:        "bd57eea27c70acef4cadf3893c47cc5495cd20344ee2ec80f5298e548cddb8a4"
    sha256 cellar: :any,                 monterey:       "1317f61878521e816e017bd09e3b8ad21fb306e89a9cf43c8a68a5ca62dc6f9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14ea7355617bbb96385878169edfbb17f28d35eb9c210c7a46730f00c0df98b3"
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
