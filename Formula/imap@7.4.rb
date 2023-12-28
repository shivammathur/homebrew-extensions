# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/90d58fc0f49b4a777caa489d59ff7b6b6620ba04.tar.gz"
  version "7.4.33"
  sha256 "65f5056dfacd4fe03f0642cee9e5a7c31b6710679f661b24e0497a4cd46c3b6c"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "bf9a7ad9688ab761aefa4f91b06221474699cbc67cf1d2d846091ed98a60dd19"
    sha256 cellar: :any,                 arm64_ventura:  "e370da2cdd34316b9120bc093dadc3842b8812fd0c3d3774e35284d3e2f07f2a"
    sha256 cellar: :any,                 arm64_monterey: "b3ba6d1cbf54f4a52f1c85f96e47600f0b70ec7d2116aa1daf7d18c329e84567"
    sha256 cellar: :any,                 ventura:        "a18a238da9d393815ce3743bd22db2a4f78b8a8ac2502d0ffd5a256f8671156a"
    sha256 cellar: :any,                 monterey:       "dc6bbbe441cd8bdcab4ed01c84a583a7441ad2585ce1e986f2d8e9faa3306a32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8b8acd4e2240f1f76719d7a79316f35f4fd26e2b837a9d574d06fedbee49ef3"
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
