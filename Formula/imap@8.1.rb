# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.24.tar.xz"
  sha256 "ee61f6232bb29bd2e785daf325d2177f2272bf80d086c295a724594e710bce3d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "86d3e2b9fe2d122bd500960eedd9e40e75dcc15d8bd6bf7b9a790b2ebc07eaa2"
    sha256 cellar: :any,                 arm64_ventura:  "25093d1d566dd46a38324dac972b68e20fe666bdff40cfa10dde7f631240d0e5"
    sha256 cellar: :any,                 arm64_monterey: "7d1341acaa620d052ec74bd67bc34f4903561cd466c0e265312f2a7b4154693b"
    sha256 cellar: :any,                 ventura:        "a888591a39f52bb8d4eb962ff52c550625d8fd875f4276d1af0887a54f7a2c0e"
    sha256 cellar: :any,                 monterey:       "39c14f42657da6bb2687cae5bc6c024fa65fd7fc16a6f8896fc09beff0262796"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6e115e0abc817f6b537a65cf61a0d80f3e46e02f8567915dbf57c489aad7af7"
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
