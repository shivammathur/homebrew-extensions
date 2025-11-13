# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/383aaa666ea5d825183dde9e676690f62f21ad88.tar.gz"
  version "7.2.34"
  sha256 "3b48ab3d2f57cc29e793846446024f7e1219641647bf1d678a5effe460358d4d"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "fb6a6a403c79e9d412f8aa5ad3bb36ffb0b9bde2706fbb168d8178db1a27bda7"
    sha256 cellar: :any,                 arm64_sonoma:  "aa49289985bdd2dcf59ae283750fbbb110d46ed8bd8aec3b77d64586705cf17e"
    sha256 cellar: :any,                 sonoma:        "c2edb7f89a0a5ea4f57e93d3e8b1cb86734f0fce082425d5d2511d64186e47c9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2a6a002353f2f43837218d5e6ef6920d4b4495f61eb729e5a7b278bdfe2dccec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b559b7f4bd0a5bb4decb0ec86c9b24815883231138f1cfa83ff4fb0dd2d49e85"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
