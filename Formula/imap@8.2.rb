# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/dbedb69f6a1a3308b9ad224c3b8dc300cd0fc428.tar.gz?commit=dbedb69f6a1a3308b9ad224c3b8dc300cd0fc428"
  version "8.2.0"
  sha256 "360c9a3e2a2bce4afc499ba230aeb4332be2503d4072684c1ae7f821b7aa6069"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 77
    sha256 cellar: :any,                 arm64_monterey: "1c1d73147283570fd0ca7fa292ce9a6fceb5d05e53f7f5bdafccb5b79380a0e1"
    sha256 cellar: :any,                 arm64_big_sur:  "87a4eddf0bfbfb8e879145ae26a6fb7875768f6dc54dd155e5b452b2f9f51ebf"
    sha256 cellar: :any,                 monterey:       "221895624d1925dbf2225a727b3cae8577f16683b2cdecb9db3b52d23c29e9a3"
    sha256 cellar: :any,                 big_sur:        "9ff40a819b83479e44d7aa5530649c9d46b4d88b3e88df0e53c4f7180fe28d54"
    sha256 cellar: :any,                 catalina:       "555cd95942423e6d35ed67f8fe9d1c010bbf783922eecc6f0bb42f93f4d6c39a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb5ba614877d41ccdbe2f0ce738dc77df3d8a2902f585a62fff1ea4d1b106fb2"
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
