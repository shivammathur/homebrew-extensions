# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/da523060fbca5141aeb3dea2cd6dcead4a690970.tar.gz?commit=da523060fbca5141aeb3dea2cd6dcead4a690970"
  version "8.2.0"
  sha256 "28d72a4a2372d81464c0a26024c00c79e270d8517ca8ff5d6ac0012f58353826"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 58
    sha256 cellar: :any,                 arm64_monterey: "99fb0a36e74c6bc0eba9e359886b4ca10e8e6dc345149c082162afb79672e66c"
    sha256 cellar: :any,                 arm64_big_sur:  "677af62b66771717ee98c04beaddacba18474fe178642f7f74ba8abe0d546295"
    sha256 cellar: :any,                 monterey:       "9920d7d7bdb0a7e48f631ac0042f427176c71e3efd8f020e5b74952988d60606"
    sha256 cellar: :any,                 big_sur:        "7f7237dd75ef2a0887c3e947354b38deb38f8fa51f8a96bf99390704f2af423c"
    sha256 cellar: :any,                 catalina:       "20be58d8481903153b12054a77cb540805392374f5d05ddee437845c986609fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f365a5e3c7724489138537f2a7194261ed242386cb51e7351550efb54f1c608"
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
