# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b51a5c353ad7e1d702cba96b94517762821235b6.tar.gz?commit=b51a5c353ad7e1d702cba96b94517762821235b6"
  version "8.2.0"
  sha256 "618bc2f285c851fd9512ff7c0b0cf2ccfd0e945f7cd4d597f360d4d50346e8e0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 49
    sha256 cellar: :any,                 arm64_monterey: "73d37691ccab77a0edeeeaff07cc8b70c430a8265425e49c68499464722f70c8"
    sha256 cellar: :any,                 arm64_big_sur:  "d081d79ae428a1ce056be16176595c92a6364b8e5249b5bfc5056f4d280eaad3"
    sha256 cellar: :any,                 monterey:       "e67eaeb88415273bbde05a945a8310f1400c8ef7409c8761214c0c176236b117"
    sha256 cellar: :any,                 big_sur:        "f2f93f8a63c0a846fd0d984e2a03d4a9b4542850ed67a3e215261d814e04d599"
    sha256 cellar: :any,                 catalina:       "4691df073ab7eb8a2620b77000b3ed9f7e620f4a5e07168148f7a8d1a8c88fe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "96a1c32a0158889b0dde84d256b35acb89d72ce2147c17aed80d1013bd14ed15"
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
