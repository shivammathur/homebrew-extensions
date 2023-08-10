# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cb927e0fc043cb454ee58b7485cbce191df5d512.tar.gz?commit=cb927e0fc043cb454ee58b7485cbce191df5d512"
  version "8.3.0"
  sha256 "34f6839ff21ea51fea0ae01a9671acb7813d87f8c843ae9fd1585db6d91349af"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "260da7d11d8a529abf105e3ffa9895c45bd8587064d63d32e79f3b7d6a1adf7c"
    sha256 cellar: :any,                 arm64_big_sur:  "9f0fd48161be50084373d383dfbb5bacc68531abf7521493da40279efcbd0f38"
    sha256 cellar: :any,                 ventura:        "01c3fa51db78e71fab425b88c303e622d1c63492a8a094fbb3154eb2a34a928a"
    sha256 cellar: :any,                 monterey:       "e869300a28af1580a9e47e91b34ea8c1dd57da5832128afbf5328abac1625166"
    sha256 cellar: :any,                 big_sur:        "b81c1986296b1f0c4b68157464b3c441ed8d31c0cf55c9201c5a1876519ef084"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f983bbcb28a8682051f2c57af341b9c89c6f57c9b870f8c4d5ad5f1fbf2e816b"
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
