# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4f0b7adf91b6398d1591f613893f90c33da9e0e9.tar.gz"
  sha256 "2f9e07b59658cd52fa6631c3a42c2a5dfd5802ce3255f5aed2d4f1a3d060bfcb"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "0c03343858f73aa3ad0547d3083ec2242e820530b14b8d22573dc5959444ccd7"
    sha256 cellar: :any,                 arm64_sonoma:  "9ebdc50ab126e5f24ac0f61104642879e6ea510b120412b7cf8d089a6a447a8c"
    sha256 cellar: :any,                 arm64_ventura: "e4a896e184d7054dab05bea71d3499688de4789423693ec8910e623e86aaa6e6"
    sha256 cellar: :any,                 ventura:       "5735b19919a5aa759417857cf0043717ba08523a0f3d3c04e545bf6ebf2c6ea3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0c8c6342ec8be764270ae26b50270c78221f8fdc516b83a85b099765df3298d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01fe7a39e4b6bacb911b587ab639065f781dd0218e0456fd978bafe880f213df"
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
