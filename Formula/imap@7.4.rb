# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ebf2eede125ca175021f31f8d01f8846809d29.tar.gz"
  version "7.4.33"
  sha256 "e73a44e447959b73f61a0ea65d8dbb5e695981691153c0c3180759f54227ebf3"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "5ead14a6f9d643dae5f1a1791fef99b47e60a2bdbf900c491320694b8b6dc7b9"
    sha256 cellar: :any,                 arm64_sonoma:   "e6c9ec5001fd0fbf450d8e93039e42a9f4f2eea539542809d1ac433f325b9e3b"
    sha256 cellar: :any,                 arm64_ventura:  "398bc8545e3b95410db348fa30261da213a222c14000caf630d87333bbd50fab"
    sha256 cellar: :any,                 arm64_monterey: "2600172eb31a402a0c67b254799427e1752202642ea0280c9b7f19e106d2d815"
    sha256 cellar: :any,                 ventura:        "4deb2c007b315fb28eb6900b834dd657eb74effecbd5dd1070421c54773a1915"
    sha256 cellar: :any,                 monterey:       "9f4e968ec6b83d5a0894efc1eb8b38d505c63330a740067dc93fa3fbc17a4c04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24b79c399db8a3704282d6f15828e6066e52b52246d6f0322d34fb76f18a1938"
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
