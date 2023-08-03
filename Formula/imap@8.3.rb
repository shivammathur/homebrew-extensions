# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6f6fedcb46a27cd3530f0babc9b03ce4598f9eab.tar.gz?commit=6f6fedcb46a27cd3530f0babc9b03ce4598f9eab"
  version "8.3.0"
  sha256 "7c2889c5e12332db85724204c5891a221aa32faa0226078018d752e187f7b413"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f1e19cc6973e34d7db40d534917dd298c34b4f6e393770035a6fbf5dc027833e"
    sha256 cellar: :any,                 arm64_big_sur:  "9c0f557c75fe4648bb1046cd805c7954d22da10a8d8e58bbaa2f5db3a58ee4c6"
    sha256 cellar: :any,                 ventura:        "0fd7b00767daf4a0524f861b22d81bc1a170b2f3341216468a7098ec042e2438"
    sha256 cellar: :any,                 monterey:       "125cefb234ffc965573bdc4421cab61379d0bad9d20975920a64a033f76cc4fc"
    sha256 cellar: :any,                 big_sur:        "b25cbfab05dcb46fe59efb44d9d4c4dee1a31469fcd8d0c159a6d68eec287a6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bd9049f1d1bda4cc3c7a1b4c2a8f832a2ac8663b5e26e4abbab2d22878b170a"
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
