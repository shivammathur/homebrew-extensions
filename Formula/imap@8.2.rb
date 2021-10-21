# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9edf825eab55fd94b9313eaadcf03227f9f23282.tar.gz?commit=9edf825eab55fd94b9313eaadcf03227f9f23282"
  version "8.2.0"
  sha256 "99d9592b08b82f1065e50ec687c96fdd28022f5982ed65687bca8ed16f21ad51"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any, arm64_big_sur: "952edced383f92de4f1278949286b3dcc5a9181310c20c221788e9db6f7e05c5"
    sha256 cellar: :any, big_sur:       "7b97093c91df2942edfccb42ad36184b99df0823d49af99b173b15820ca9485e"
    sha256 cellar: :any, catalina:      "3f146bedec90fbd5fb82e9ac0768e6b1f3d1e4ca7dec342cae9958e348075b94"
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
