# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f9a1a903805a0c260c97bcc8bf2c14f2dd76ca76.tar.gz?commit=f9a1a903805a0c260c97bcc8bf2c14f2dd76ca76"
  version "8.3.0"
  sha256 "009e5a280eb49d32d324ed781e5edf41e66088ffcffa85543e6af90acd468ac2"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "b5582977cbc6c0dcabc80e3d41aba14decf718e758ed5b3f91d499dcd0d484e3"
    sha256 cellar: :any,                 arm64_big_sur:  "10d43daf77deadd31f4aaff083d2d9d58634a1d9183000d09aa750832f9ac1e1"
    sha256 cellar: :any,                 monterey:       "2920c051f8cc3dce7e0342f1aa1ced66e5c76949363773677c4464851c048b6c"
    sha256 cellar: :any,                 big_sur:        "9f0391b705105fc74b214def4719620c7eebfcaadbca61390222bb9357790cae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f177f22eeb47af6a0ecd7b237e4bac8bc074246e83aa51c58e6e7e9487f3c4db"
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
