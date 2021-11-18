# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.13.tar.xz"
  sha256 "cd976805ec2e9198417651027dfe16854ba2c2c388151ab9d4d268513d52ed52"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7757a011fea8b6dda4a3aed9e4a2fd4d15c769dbcde2189a1a1374cde7a58098"
    sha256 cellar: :any,                 big_sur:       "211df132b19a9b0de366161dfe554b7e669aff80a11640e81b1cfa21f059bcf6"
    sha256 cellar: :any,                 catalina:      "cec5ca5a3835ef21e2c3e27353257d2d8307f728eedbaf58aeebe771e2713ace"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d69f4eb0869356a3909912ae0c0917940d71d0f6e79e039a1dd582c24d9adb0"
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
