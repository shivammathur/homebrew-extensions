# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e5b417c927f43ba9c4b237a672de1ec60d6f77ca.tar.gz"
  version "7.4.33"
  sha256 "7f9b8e85407c223c3a45e11c1bb4fbebf66ef7c9008277eb1ddba2b5d1037384"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "2a3ee4b3127d87ff1f54913c48afe272f3b8792f45a2de78ea7c74dd581c728c"
    sha256 cellar: :any,                 arm64_sonoma:  "4549ddd5dadbed6f519d756c754a6a0b2b460e5122f4ce433dc57b9bc7482015"
    sha256 cellar: :any,                 sonoma:        "95beb6f77e71486ff3f5ed451d8d2fe4a2c68d74418f465606174bed1e05b445"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa5419a3b0fd9820e92b1c1c8004a9d88d747f39b5cabe875c8e257267c90722"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "adb0391c05e3b55db6214bd28f9bd3601b4918c06d1dcfc55a43b0715fa66f8e"
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
