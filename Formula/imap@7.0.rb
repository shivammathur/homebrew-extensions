# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f6db3727459a649d4d9912ce3fdcfec95fa6ed02.tar.gz"
  version "7.0.33"
  sha256 "0e8ab03aaad5a113b693ae3999f7ed7c750b15a514714856840b0ede3302c5ba"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "4eb2caca6fcee3c3edcc23e6a37b372fa5a1dd7bf873c7235f12108a5c968d44"
    sha256 cellar: :any,                 arm64_ventura:  "13e72f1c7aa85868999cd70cd3722dbfc51de9c0716d3c04f7805f1c1ac6b38d"
    sha256 cellar: :any,                 arm64_monterey: "c6928df77e2f3aab7a9b28322fa557e6b54a65f1f840821520f6d947f0c6cbf3"
    sha256 cellar: :any,                 ventura:        "431a2473ea738206fa5c306bf83648fd0e24c608ac4f693413147e3b37645332"
    sha256 cellar: :any,                 monterey:       "799e8cffbeb31fb98444ae5593e037bd5fd4638f34fab47a36cfc4a51adf29b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7de315cbe26479320250e4af6db742429a59c5ce7f29595250dd41f84f144ece"
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
