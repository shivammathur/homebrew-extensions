# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0a1a9997c70d649c9940d71c84a299210b74b0bd.tar.gz?commit=0a1a9997c70d649c9940d71c84a299210b74b0bd"
  version "8.2.0"
  sha256 "18723eaefd5bf466be3d3110a250ccb9454d28038f6c16a36e16e54450cb1272"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 76
    sha256 cellar: :any,                 arm64_monterey: "b6a1032c44f8840e8f44e7e25874d1a88b2cdf22f2ed10a31bd345259e88ca03"
    sha256 cellar: :any,                 arm64_big_sur:  "bb0b560e5d0912e3d276e5bab1b5f35aeb1e311680e01abb20a584af14926b48"
    sha256 cellar: :any,                 monterey:       "8e80f4ad85f32d1895cdde6b39ea1f93bcb39b04472e79db056e5a81d7bdd42a"
    sha256 cellar: :any,                 big_sur:        "ebb0eb3fe8aa0389f93422e4ae90e1efe0ba54504e7dd610adaf3d392cb4e3cc"
    sha256 cellar: :any,                 catalina:       "b9ae6c5fb532265880b4c692d662b95154e60792644b6d0c8a2d18de6936d272"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a3957144c64166ff2718eb51ec7f690d946f89873a628352a25d62cb44a5d41"
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
