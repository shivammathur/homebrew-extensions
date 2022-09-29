# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url ""
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d9441b9a7b3076e458a935e4b5ac627e63df742bc1b48cb6f942e4c437a38e30"
    sha256 cellar: :any,                 arm64_big_sur:  "8a2bea10bb034f482868caafd1c7a4c8f0ebcfe4c9f9bb66115e0cd92375f796"
    sha256 cellar: :any,                 monterey:       "8211cbb1dceaddee818f33c5da3f4613114700cc75ce473ed28aff9512db9d80"
    sha256 cellar: :any,                 big_sur:        "7a8ed3ed4b9075619a0f1d4cd7c417a5bcd25440cbba0e95b2f853ad766f3ce4"
    sha256 cellar: :any,                 catalina:       "9896360c22448ad6c481df0c3fe02fe2852f5f201017663101dfa185bf223124"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e79424a77fbe180c5c3b2c1317bfb5b52108a1c4c6cc9ab11f84754e4e0c8c7"
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
