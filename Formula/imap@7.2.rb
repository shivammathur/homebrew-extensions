# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b7176bf97b38f49a10964bc64a1eda34a3d4a0f3.tar.gz"
  version "7.2.34"
  sha256 "e2f8001ac0694e3f024b56c3d5a9840d93dd806565073fd6500938f4759e4948"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "16ac11172b098e5434a5b7f7a960b1be6eb8c00f2b7649193e6847d94439827e"
    sha256 cellar: :any,                 arm64_monterey: "01ea25c9e283eaaf20a693cb5c191b394e7f24a54e1f05c6300bd153fb1fd1fd"
    sha256 cellar: :any,                 arm64_big_sur:  "768db6abce51a65be47d5c91710a57dbfc3391da16784f677f7d6441caf6024c"
    sha256 cellar: :any,                 ventura:        "df68cbf145871a555a4f3db2b3f8c08e0fca718ee9404aa6301c25839b8d11b1"
    sha256 cellar: :any,                 monterey:       "0fe45aab8d815fd0b820e898c3b074b913ef1377d0743e0e911fffce94496393"
    sha256 cellar: :any,                 big_sur:        "e5046b992094987aede3893a4ebe57fe0206f51438c17aa22292f430beb1315b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0bda40918f86fdea99b7f6028c1d1ecdc99d0cced5dd99b0f015aecb5fa3ad8b"
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
