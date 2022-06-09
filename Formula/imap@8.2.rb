# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c83b57096acb6fbbb49460983c26029583458470.tar.gz?commit=c83b57096acb6fbbb49460983c26029583458470"
  version "8.2.0"
  sha256 "2ce7556bf2b8f4f7d448faaec38188367832df26f0713174917b247e15215b4c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 55
    sha256 cellar: :any,                 arm64_monterey: "f6b8ebaf0f6661a1e5f58a98063f6ae709462fde46e3018b57cb3d0895e4c584"
    sha256 cellar: :any,                 arm64_big_sur:  "2f188d51a122341e930484f63cc6513f4dad163a67562d1f72e7144f89c742c8"
    sha256 cellar: :any,                 monterey:       "b2eaa12d079478497472d6964152a7c43594a368e837fb2e5494f962a0d3da2d"
    sha256 cellar: :any,                 big_sur:        "002590a40e4b915a8604edc3978d5bddf7d98811de86c40198aa92a722128bc1"
    sha256 cellar: :any,                 catalina:       "62516a43321a8d2570a56109f06a2fe6964682dddfd7ff7b5249e987a7563b71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ece39f8cc56f7494dc472f6ede50c2897bb45c9017e9fb85b2180662a7e4ce9"
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
