# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d312a0c8007ffd398cbbb3cf9340db2654513cd6.tar.gz?commit=d312a0c8007ffd398cbbb3cf9340db2654513cd6"
  version "8.2.0"
  sha256 "ab2e4371a03823e93b1de5a6177cdd1de5e99610834e2fb05ee187dc5fc73f3a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_big_sur: "8018878b434a87a121dca716f3607872fc4bdef985da31e8dcbc36733dd03660"
    sha256 cellar: :any,                 big_sur:       "c99dc0b04c2463fb353b4101b464740905f481c2580d0828c9cd99a962fb4f49"
    sha256 cellar: :any,                 catalina:      "260e5f4039e64b753a1409368581eab1c9ee76aa4317e977ade88860ff703c9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fcae7dc779117c7f68e578187ba3d40034459b33ea7cd0b9112f63b5ee16a668"
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
