# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5ccfb6d3550d977f95b0c8338b2e5f99e05a31b9.tar.gz"
  version "7.3.33"
  sha256 "062d12fab7d94b517a64c89da2dae480a4ffc0af72e80342166fb6e1c105be76"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "9e63bc8b7d046a711a2de3d251f069ebb0acd9823ec1c59fedd38801ce6f0b27"
    sha256 cellar: :any,                 arm64_monterey: "f97703b34a9100d29693375466a61be9b25675fa53a8d077c7f0a187eb7ba157"
    sha256 cellar: :any,                 arm64_big_sur:  "bdf9055a7b84248f70338aa538b89a0beeed71ff0e7d0a7a5452a643d32a6ae4"
    sha256 cellar: :any,                 ventura:        "142cf0287197bffc63557b65cf475894ffa96b56491be964153a93ca1bbe3e8e"
    sha256 cellar: :any,                 monterey:       "00d0b3fe4e89beb22eee0d9f0afc27cec8192c1b94a60762a6cccd94c8130a20"
    sha256 cellar: :any,                 big_sur:        "408e52e31644e448130d1e0e4efd8326fd15a6cbdd9e85d1c787c5d2037a22af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5492296e3b2cce7d360cc4d6cb3c3d2a59d89c6bbcb3d3d2fd0eb2a91e65b4fd"
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
