# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0429159775658f9b9f81d67e4206cf449da01679.tar.gz?commit=0429159775658f9b9f81d67e4206cf449da01679"
  version "8.2.0"
  sha256 "9bbd3697ffd9696b58b65af57e43566e7321a6e95dfa18fc1814cacc69cb8e82"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 56
    sha256 cellar: :any,                 arm64_monterey: "f9e1ddd1dd22aa6ace51a4025c4cd75abd8c0884dbbe42d23fed35e5ae7df8fc"
    sha256 cellar: :any,                 arm64_big_sur:  "e161d0e14b398c1c8f8ad1628ae1941a3dca7838ff0fcdaed91b995bcc0bdc05"
    sha256 cellar: :any,                 monterey:       "b7ad3312d444d4987b2429255785ad4ec868b2297f617640ca88c8892ad49036"
    sha256 cellar: :any,                 big_sur:        "e2eee92c5e4de88ca1a61206609f6773d633a62d73fbaede6d2fa7f66d7d6673"
    sha256 cellar: :any,                 catalina:       "4958be76d632503d8052dcba7cef53bf7d3af8da21061cb7a9fedd04f464f78b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26d870cbc55263e5579db9176843548000f202743f59f0b947ac1668487c891b"
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
