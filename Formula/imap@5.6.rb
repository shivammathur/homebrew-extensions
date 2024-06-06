# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a372dd10f71f5daebfaafb731b47befb1de4b4a2.tar.gz"
  version "5.6.40"
  sha256 "acc3dd520f6cfb1990514817d7ca69aee2ec99510a7771892f46e2635a83aee6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sonoma:   "00919799895b53a073fd7f20583734aedc2dfffb261f4fd680b566e639d7d8af"
    sha256 cellar: :any,                 arm64_ventura:  "57b1cb61250758a44ec0a4e9e3c4b8351e90072e033d3a44cb24b527913b04a8"
    sha256 cellar: :any,                 arm64_monterey: "076abea71d2e79bdbad5b3a519e86227da2f1bea937d33d65189461e8e3bd402"
    sha256 cellar: :any,                 ventura:        "b59b4e8d7eaccb34e07d4d9569ba56632b4cc7feeac28fc4a252ed8bb6e73815"
    sha256 cellar: :any,                 monterey:       "520c35b5849445aa0b72eeccc2ea51997164ed76ad9f449ecd9448d648e70a21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "364726fa0883f76a1e1f5d8e48284715cf3359bd4bd91eb1137ac27a1fa1641c"
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
