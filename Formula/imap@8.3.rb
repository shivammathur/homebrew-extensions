# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8995f602584a5267999f51cbc73f8c03eee36074.tar.gz?commit=8995f602584a5267999f51cbc73f8c03eee36074"
  version "8.3.0"
  sha256 "f20f5b318b780fc8436e10988dc407e4dda61220f4902ae5e90e3a1178b6a52d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_monterey: "3d4ee9feb90e77120a1ed9ffa7470796b317b32dc1e6956e3de96e4f36a146b6"
    sha256 cellar: :any,                 arm64_big_sur:  "0646b34d057099f9b99e2ffb0ecff4f227a88d565e504e3743a8e00a73f2e11c"
    sha256 cellar: :any,                 monterey:       "26efcc6f57600bf5b65adbfbb7139f19feb6c7d7a73baddd864486fd83e79546"
    sha256 cellar: :any,                 big_sur:        "e97c65b096b9e2950f8d1fca75e135c8e3a2a06ba723992939863324aff35d14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a637dd624e9a64f121a3858dc15a8eb11b2792d18a4921a2114a67528a9a1e3"
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
