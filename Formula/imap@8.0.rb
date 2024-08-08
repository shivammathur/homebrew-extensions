# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/40743b5b2a481b270701b7918582dba33406db6a.tar.gz"
  sha256 "0fbccb4645e05932117697d4ef6c37a7c26b1e22b0a017356da5c64577e21469"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "b2b64809b7dfddbf901682a925e6da7b713808d37908b3f19ba128311fb52609"
    sha256 cellar: :any,                 arm64_ventura:  "3394c6857e8b2e333f3fd6cc41489b7547880cc2458ddfceb26e0cd481088b8c"
    sha256 cellar: :any,                 arm64_monterey: "9a0939478f40b61128c58ecc629f602e9195e7d1fa4381fd7260efca95e0959e"
    sha256 cellar: :any,                 ventura:        "878ab6ac2159352ff371cc0d8dd8e0a2840a682acb7f2d8d66565fd37f36872c"
    sha256 cellar: :any,                 monterey:       "ce9dc03a3badbbd9437ebe432818ee144fb7d6da8e3ffdcf26150ff2e373cc2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c69459680ec1186cb792c3c0e435771ec1375945545dcba8f77012b5ac0ef749"
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
