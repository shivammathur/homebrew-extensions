# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3ec3a5352eb55a241b2e22e54e711b24f1542df0.tar.gz"
  version "7.1.33"
  sha256 "68e64a7a50b5649f3236bb39db32aef85a1082345ad266fd0af107d69b53b0ed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "dae1d6fd2d811f5016a25788df5eb9ec11f4573ad0350282a0cb3e6265ed379e"
    sha256 cellar: :any,                 arm64_big_sur:  "e47c40c5c07b10e66a9ddef049b68d893f6298e787f21328a927e25c55cd5453"
    sha256 cellar: :any,                 monterey:       "b60362149f7f12822317bd6fc915213d4cdfedb2b4a654a7f1315c9668869947"
    sha256 cellar: :any,                 big_sur:        "8eb3a9a59436426802e99113e724830c1567336a9e50e1dde6b24a2012e3c345"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bd7fa3f2447cbc77635c158d11eaf42f6bfb7bad8967563d2dab7306c02fdad"
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
