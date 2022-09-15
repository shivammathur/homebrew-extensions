# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7e860eaef01a8ae5009bc0ed046e4eb1032411fb.tar.gz?commit=7e860eaef01a8ae5009bc0ed046e4eb1032411fb"
  version "8.2.0"
  sha256 "ee239c5463111497f0cc30dc2a3447c58a3b2c93a6a29dfcc34defe5e826d52f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 73
    sha256 cellar: :any,                 arm64_monterey: "4dbaf6af4100e09bd5fe9aa0969b835ada135ec9a971132a7c7c2ae4f5d11f11"
    sha256 cellar: :any,                 arm64_big_sur:  "6310c0c1a32b78056cbf8269640ec2ff9d375e2e4369f46f8def59b329dd69b2"
    sha256 cellar: :any,                 monterey:       "491463006ae8c0e584e8f7c93c84b5c40c5433832b4ab136004197580f3b4573"
    sha256 cellar: :any,                 big_sur:        "f0898a36637e2c109ef15cd8d2447d7906b673a855f252bcc2044baa17d15948"
    sha256 cellar: :any,                 catalina:       "8d4fa45667deddb70f36d7271d18013d053367a4db4e09ff8b4f8239dd4072d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35e7fe25ad19c8a7219c3a2da74450cb4aa9a320f1a3bb0519377802dcc6286b"
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
