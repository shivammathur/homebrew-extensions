# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e5b417c927f43ba9c4b237a672de1ec60d6f77ca.tar.gz"
  version "7.4.33"
  sha256 "7f9b8e85407c223c3a45e11c1bb4fbebf66ef7c9008277eb1ddba2b5d1037384"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "e3614eb90121322d3a195c3426617b32a26bc157d33e5eec8edec53d213f6e75"
    sha256 cellar: :any,                 arm64_sonoma:  "21f0d229db48e17673fe3f1ca333e5e0a4192e9fbad1ddabbbbedbca75dd4795"
    sha256 cellar: :any,                 arm64_ventura: "06006809c827e44714457297491852b6a512e4991614df9277c28fbfc7893655"
    sha256 cellar: :any,                 ventura:       "250babde8994e7f46f8c09a2da8122361b7f94b05b375607567b6256c468acbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9212abeb101d59532bd210aa6544c704e88aad4cc13fa7930a08a56e7949e048"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b5c6e601813f9bf6ecb03d8c4685fdee469667b8e7bb9b829effafba40e6c6a"
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
