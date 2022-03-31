# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/48e07076209c6163ecb4a756f73f511f1f09200e.tar.gz?commit=48e07076209c6163ecb4a756f73f511f1f09200e"
  version "8.2.0"
  sha256 "a04d02ba674367cbb1dea34fbc325e2ab71bea1ac8974d336bf69a9b7359bcda"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 41
    sha256 cellar: :any,                 arm64_big_sur: "e7dbaaabb4c5e22a51fd8339872e2db286fcaeea3ca133ad770efce841169375"
    sha256 cellar: :any,                 big_sur:       "46ec5a35c48efe78ee3af8d2a91a53259e7f9c51f4b5a89e5f670ebb3b9c895d"
    sha256 cellar: :any,                 catalina:      "3f64341ac4e951d3b7518b9b66ff3612575c1c16dcf201456a0ff0d000bee0ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b707b8282754e62aa2b1bab0ceaed887bb8acd504541134559ddffe9e2f38b1d"
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
