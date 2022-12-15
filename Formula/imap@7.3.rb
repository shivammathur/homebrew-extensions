# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4aee3505738a19db5cf17dfbc6482a509a0919be.tar.gz"
  version "7.3.33"
  sha256 "ad149ad8bc894bddca13f8fb8d1a8465ac165e8386480f73b6e16c9de208239a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "fa41516c1b8f7701fef13949db42201a0d3b9144a3a96b0c7d5d2131163cbf02"
    sha256 cellar: :any,                 arm64_big_sur:  "a8e7dff31c4c82c9fb4a4f6498d0d13eecefdde9934c3473986036e1bd187fec"
    sha256 cellar: :any,                 monterey:       "886e3c38c749566521b1482148be7adb06ae09d6fdd842868781df37e5deccd7"
    sha256 cellar: :any,                 big_sur:        "dcc80ef8258f4d18f788a3e37d0503f028a1d2c45bac3bb3bbbcbd2253eb7d44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "347af6491f9834062a16db6a70bb09db412fa8e0f0a26abf3dfc0fb8a2089699"
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
