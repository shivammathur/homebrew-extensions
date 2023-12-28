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
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "15d9da9a6ede060344dfbe371a0d292ffbe5dfcd45619856114916ee4dcb49a6"
    sha256 cellar: :any,                 arm64_ventura:  "8272dee683da264587a5e0c3e1df28ae22502307532276e9aeaa9faec179e43e"
    sha256 cellar: :any,                 arm64_monterey: "a7e1f996ca413136fec8b8db836ced3e8be3cf539b881ab62ffd0c7cf0d7718f"
    sha256 cellar: :any,                 ventura:        "434829c0d557011539f775970de4101516115426fed3962266612c6d51e0c0cb"
    sha256 cellar: :any,                 monterey:       "d048bd779cef4521c954f9966c3fe7f8f53d67b1c9443e9feb7454e2b6ca3b36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "385f64d18201af8ea1631e65e15fda2bf4070184a5442e04d1fd892b552654ff"
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
