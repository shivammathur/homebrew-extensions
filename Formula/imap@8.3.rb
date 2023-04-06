# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c796ce5713f21a3de77e710f4028c62f45bc0fff.tar.gz?commit=c796ce5713f21a3de77e710f4028c62f45bc0fff"
  version "8.3.0"
  sha256 "a18ab59f65fe42870f2085fb9ef293bf03a39e7f7021c08f710503e287bbd885"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_monterey: "bf62a53f128319542dd25a9491bc647dd8ea9449a7ec468273ea4bfd77f645c5"
    sha256 cellar: :any,                 arm64_big_sur:  "ee3008f8c9ca42328e39053012cf8265aac315da3abca328f5eed67568987bb1"
    sha256 cellar: :any,                 monterey:       "6f9135259f57542fa22220c4b6dc7eef7de6ebf4924fc8fc512abd0836ccdb86"
    sha256 cellar: :any,                 big_sur:        "3e705dc1944af97daa82c5ec37361cdb75d0ae737943748f69a3ee7fc4bfb03f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b2bcc69abbe9e864cc3380e23e56c8237ddb795c7cd68f938f5b64a2e1fed202"
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
