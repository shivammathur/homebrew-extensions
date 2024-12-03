# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e62bf3dbf92627e79283013f6e83f7a4e5ab3e6f.tar.gz"
  sha256 "0ade4ad72b41f3e1c05e001dd3cccb52800eac770f5bbb9472674bc1fa90920d"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "2de440b0c283c9fece1ce7795f482a8f271f93b1556deab8e231251017fa5e03"
    sha256 cellar: :any,                 arm64_sonoma:   "65b5b26c8167ff1b4025a005b93f5bffbda9817ed6931a67d3614740041521bb"
    sha256 cellar: :any,                 arm64_ventura:  "cbe7da68eb5161fdafe9ee7335becf892ae83072c0c040629a402ac864ea8d1e"
    sha256 cellar: :any,                 arm64_monterey: "bddf6bd3b96f190a350f4f1538b489ab861fce99bf9e3fd9c3a49e0c238a1dfb"
    sha256 cellar: :any,                 ventura:        "135536ac3792b48232b765a0b5231c24a89b7efb1e2d9bb4f8360e70016ff97d"
    sha256 cellar: :any,                 monterey:       "9a6c79a2ab38e797b8cd8ef84e5a4d63d0f48e92713ecc8ab481d5c33162c905"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "653025c71519b8b73607e119444b498c08ee5655b63486c5243bd8a3282030e9"
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
