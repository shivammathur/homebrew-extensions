# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ef5ed06d3cc615ad3ae5c7b7d601ab9e4a35111e.tar.gz?commit=ef5ed06d3cc615ad3ae5c7b7d601ab9e4a35111e"
  version "8.3.0"
  sha256 "a6c49347aba53ef64975cc4580bbf4f97698c5e5836f821721a67794a6e0c787"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "b4c12f152aa7620e720d2d89647c3334a88bfda5ecb74616cef4052fada4d50f"
    sha256 cellar: :any,                 arm64_big_sur:  "c40cf5d2df058540cbe24bfe1e259b5bd81ebbc64d8e48d5ce1f78acef1e10bc"
    sha256 cellar: :any,                 monterey:       "f0d9571c88fb426b4e065d920ad8092cc00fbc004588d624706b856d69190818"
    sha256 cellar: :any,                 big_sur:        "4e50227f782fc06baf03cd7217ba6790c7383a31a1b72e9b42401afab5c0b520"
    sha256 cellar: :any,                 catalina:       "32671d55e9bb7fb3f3f32fea5dc12bd7f5bb32bf1ab0df22d2c673d4c072d364"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5283128deddda5ddd78b879872ab73777082a65ee746c87df69fc3f0ca877481"
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
