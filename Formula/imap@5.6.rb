# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8e9bde45d8f4cfcf72f5a730f4fccf907eb5c35b.tar.gz"
  version "5.6.40"
  sha256 "e6dc16ae13225a59b718ffd44481f67d2df8bdef2af625f19229a1c08cf52303"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any,                 arm64_sequoia: "941aac4296b7a455a89ebd946ad396c861afa2317158b53e31c9c521f6b7d83f"
    sha256 cellar: :any,                 arm64_sonoma:  "1e0e8aecce9be250321cac1ff0c5adcd4a96d56d73d94a505c356b27d807a7b9"
    sha256 cellar: :any,                 arm64_ventura: "6582bf9158d405e83f279dbe8d706fc4ba9bd53072af5f48d5573f1c26e93dd9"
    sha256 cellar: :any,                 ventura:       "4f96718f6cd519087263747932cad91faaa1335a6d0e6d4632d57ddcc6ba1be0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6827a9146da0c8c884f11ed6a01f6d5cecc2415fcbd30b4dae77cb8fcb94c6d4"
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
