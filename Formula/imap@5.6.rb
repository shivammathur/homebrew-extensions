# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/30e5da4b4bf8604149f19d4f73ff2220da3205aa.tar.gz"
  version "5.6.40"
  sha256 "63619b43de54f884a87f638a41f827c1b978ee3deaa24e0266922f6ce49a78f6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any,                 arm64_sonoma:   "785bddcf0208701f1f62133abd4fae28b4a6f3f43a9acd89f862e429b9bb1077"
    sha256 cellar: :any,                 arm64_ventura:  "9245b05fbce551063f196d34ad386d4654fac103674c3beb0607c165391d0739"
    sha256 cellar: :any,                 arm64_monterey: "73e0159249809898c583758fd4c7c5808f9fa984e1948b4729199004185299c1"
    sha256 cellar: :any,                 ventura:        "b99b50c11ac9fe16bb84baf2f207e69a563ed0cd1ebd6793439ce44d92354b95"
    sha256 cellar: :any,                 monterey:       "f2b505b0e7852e3172b576487fc36165ec54e7b760eadc70b06d5e1c4be5c7a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "778e85de29068f3859aa1be6e238c074ebdcde1ee60ae608da9938b6c37ef122"
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
