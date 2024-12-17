# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d6623472bf262e3bd7f7f9218bb1fa9d411cdde7.tar.gz"
  sha256 "72f4f2385928664f0ae600d5e6c7c29ef643960a981676f218f4d87c400ba53b"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "9ad740ac7deb2d4e830de18fcb3d3bb9f8c626703f43b8376c3a62be0a2be78f"
    sha256 cellar: :any,                 arm64_sonoma:  "9ced4318bb8acc0126bc30803733f35f1c162404dbff68d43a65fb4623ef4a78"
    sha256 cellar: :any,                 arm64_ventura: "1f4af25ad1213f96fdf92cfe037ac6ba400aa0eaf15fafa109a87a5a763a07ee"
    sha256 cellar: :any,                 ventura:       "d5aa59644121e4e71f3ffd0f6919c813c58ea4256026d7957517c533c63a439d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afdcfea8422aa56d81ba8aa63858c9158c95a13f4ce82d457c888a1633ab9a0a"
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
