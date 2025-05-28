# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/269a597ce7d22198bca3745157a45783d86da7ac.tar.gz"
  version "7.2.34"
  sha256 "01e8a6bf83a7b5e77ec6b02d5933e12a39911a4f34bfa572d99ac0020c9513b0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "6863744ce0c2754090f0a40c8b4f785a9b825b7f7e25091be097ff927de8ba88"
    sha256 cellar: :any,                 arm64_sonoma:  "e57ccf7b5ae46c3df102bb6c914d82269790c4e53c3fc24c543636b8ee619bfb"
    sha256 cellar: :any,                 arm64_ventura: "53914da7206c6581ab29e7ebaf57721d66cae7376a6b5bef753e715ac823827e"
    sha256 cellar: :any,                 ventura:       "ad7169ea9070d3ce3e12c79f7cd9eb67d5bc95a3042dbcfa41fe2dea40904762"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "91f84e80e155ed1d07a0f79c4d24029d058c6dc59e4b457b2c3abee99c81068a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f6a2fe94a2129efb334a3375c10b47716750d7c6d4112d228647aad7d88cb3f6"
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
