# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7ff6ba7443d4691f7c7a2ca3b8f58f3cea632765.tar.gz"
  version "7.3.33"
  sha256 "6610f090bb89e34257bd22c5bf4081c485fbf53362bb1231d09141017198729e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5e2eefe15ca55434a040f069277428bf38e5174a27cb38d53c559d7abe71682a"
    sha256 cellar: :any,                 arm64_big_sur:  "ad07b54330d6a13f360f9e3ae2c2a890f3752a6a4ee4fc36b73a785b70e7498c"
    sha256 cellar: :any,                 ventura:        "cefd30f919b093a280b82a4ead4da496df381f2aa41489e52746c39e48cbae97"
    sha256 cellar: :any,                 monterey:       "c4997ef571761eb34a76a933dbc211e6ec6b2eda85fef26d547b062d457ad6cd"
    sha256 cellar: :any,                 big_sur:        "97a2e6edfe62744486be475ab049d56c3ffb55c41364f45938067d2e72006cee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b021a24c7a14c92eab325fb58dbb238c13ffd017db0fcf7dec9d56f5bd60c219"
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
