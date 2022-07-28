# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/520bb2ec6ca01698f863cb16a5e9a28764df01ae.tar.gz?commit=520bb2ec6ca01698f863cb16a5e9a28764df01ae"
  version "8.2.0"
  sha256 "159f7e9d5ff42278d9f98a40950dd58d855c92c836d73dcf03e604463364e178"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 65
    sha256 cellar: :any,                 arm64_monterey: "617a29ace574e3dd37220bb9ca330692fc24af3a8d8b31edce1a5aeb83b16725"
    sha256 cellar: :any,                 arm64_big_sur:  "83ad3eb50b59b12e268fb153518933cc5cd1a77d0726916f88db3fb98f44dffa"
    sha256 cellar: :any,                 monterey:       "e9780df1b03e73996dc52563e85e9377e0bd2872bd4f0ce118d91a197cdc9e81"
    sha256 cellar: :any,                 big_sur:        "f9fd55bd28b3e7e0c0fc2c2716f1b07f7e23d9e51df2090565ff016e7b2b6309"
    sha256 cellar: :any,                 catalina:       "c7e058a60aca8171077401902402248773c99de37c50811da78c6f40bb42fb8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5f1260d709c621316d8d06d79123f1996132e0bff0224269a1646889e9f9d72"
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
