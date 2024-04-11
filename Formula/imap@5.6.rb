# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19b4f1903d39f6a8919a73b7d1c0930cd5d89c72.tar.gz"
  version "5.6.40"
  sha256 "f2bd7d6fdb7dee449dd694c3ead14be7ed0a2d0464f39ec55786354a28c81d6a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sonoma:   "79dac1d47eb7eb4124711ad00fe365e668ca80d16a5294dc5b4c90f5a207a9ce"
    sha256 cellar: :any,                 arm64_ventura:  "f654966d572a468e9225d4c83533665ba99e81d5ad12ba5ad4201ccb7448db7e"
    sha256 cellar: :any,                 arm64_monterey: "127fbac85dd77cd1b53e673373a997a2d067deaae447061acf40bfcc5fccee37"
    sha256 cellar: :any,                 ventura:        "a4f6a2bb5df7654035dc8dca81a9869a060bda0f5a16637565d008d2848f9919"
    sha256 cellar: :any,                 monterey:       "c873cac2205392e8e7cea064d6d8b502bf307fef3916fc12b6d4986b756c5d48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b65ea7e052220d3e1b0eee1692bd2dd9985a6b45e907ee858f31c9a64fd0e35f"
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
