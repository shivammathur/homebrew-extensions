# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/663b037c7b54c1b829d59ed8f35ceb38d8cc3975.tar.gz?commit=663b037c7b54c1b829d59ed8f35ceb38d8cc3975"
  version "8.2.0"
  sha256 "d70573759e19c6b179a3ccb281c6d8d9f7350d8fcc6dd2c3335163721eecc14c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 66
    sha256 cellar: :any,                 arm64_monterey: "8335299e88ed5fab507474c25444d2aea14fc0f893c59dae3d3ab8ad1221b127"
    sha256 cellar: :any,                 arm64_big_sur:  "d243a299ef14c107d12a35b74b11f8249fa3e7c92a7de664d5e76d5d16f5e483"
    sha256 cellar: :any,                 monterey:       "b7d1badc01d13c56647df136eaf1bbeeb34fc2ae7e10beaac27a7ede2f222c66"
    sha256 cellar: :any,                 big_sur:        "e42f33a92b5df11003bd1f75e6f556fbdbe4b0d06d5ce3af159522e1bdf93219"
    sha256 cellar: :any,                 catalina:       "2ff3dc0b2868c87e81e39b1232c8c434cf288dff968098d7f0371b7ef5c2dc91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d0a34651a9e327d851a087b1ed6f95b7f7ce23b6bf57b36bbf4c326ee27cc298"
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
