# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c6a5368db2d850e10899d237032dd4d7d116c1f0.tar.gz"
  version "7.4.33"
  sha256 "fd61fe2c759e485aedb011cc87ceb8e159dce63662dd4aded0d6aeb9231edcd8"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "c608fdcb18f6b91df64437cd1a7dfdaf8375beaeaa853f652fe095d54f1970a6"
    sha256 cellar: :any,                 arm64_ventura:  "b34c613606a2d7bff0a8f7703bc7f80273143a50745baea381c05265eea274d9"
    sha256 cellar: :any,                 arm64_monterey: "6e9b89e40e6c3319bc2e6faf3ced3d4265fb1032bc16c53fc49189db7dc8237a"
    sha256 cellar: :any,                 ventura:        "a8b56483eeef171403c02d92e9469577c8cc3b270bd9504543f893b4e73ffd6f"
    sha256 cellar: :any,                 monterey:       "afd66b7d3eec32a37c04939e959b81b37491824afdbf5f7800706abe0313a133"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f04b6bf04dbc37fd3fc26eae1ab4dafee0c354458105d3fb6a2c6e5c56fbd12"
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
