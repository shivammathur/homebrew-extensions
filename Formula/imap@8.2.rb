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
    rebuild 57
    sha256 cellar: :any,                 arm64_monterey: "950210cba65cb860c3992aec6202a8f99320eb4c22067e4a212a27fb8ad0898c"
    sha256 cellar: :any,                 arm64_big_sur:  "ae6016f63c685351ed4eeaebfc6371691a76ae2253b8bf748dfc09b5079119d3"
    sha256 cellar: :any,                 monterey:       "58eb183a230b6502292dc7b1d37fbf792c0b90182aa82451016938281d0bf6e1"
    sha256 cellar: :any,                 big_sur:        "ad94ff27a163e01b976927a39b83e5885218fe932814d34f91282b581e13bf56"
    sha256 cellar: :any,                 catalina:       "0b7b431a6517a56b075256c803835229877000b805428706fc003cd63c4f4ed7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "65590f9dd08ddecc6d3c20e29e5d6a8050714cc57858b352c612079fd5e0748a"
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
