# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2351df39b3d3e61b3edc9e24813f629c4f58e235.tar.gz?commit=2351df39b3d3e61b3edc9e24813f629c4f58e235"
  version "8.3.0"
  sha256 "03fff9b431d00b593cf9f6968ed48e437fd9d9e1f8d4d885249fcf9e90d64837"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "77dd11105df831b9baf0aff3fd415410fc3cd374db0dec378526440a21a1dd9d"
    sha256 cellar: :any,                 arm64_big_sur:  "8b36dd4ee40a8b274adf6efe75acaef4d5be221df525858ccda66b7254303b3c"
    sha256 cellar: :any,                 ventura:        "101a2879b0bc9715e798ea1488b765d9aa8369f0a2e246398cab98ec204f90ca"
    sha256 cellar: :any,                 monterey:       "974eb30e27f33827ab910d90525d77cd00f94dde55ee42cb9e5c851bba3012b7"
    sha256 cellar: :any,                 big_sur:        "a9c57f1166e4f7cf24834f70767cc95c297bde21f3d20bb68cb7cd1d4a7c8bd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24a759fa28c348b31f3e80d5039a90f208daabcc384a5f6573a869f6dc41b1e3"
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
