# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4bd48d3f9148be75fca7b1a7dbddb7ebc009eeb5.tar.gz"
  version "7.0.33"
  sha256 "6a7a12167244eee464b906eac8853b104df4887f189da7111af39f198d3fcb58"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "2d8a003987705c254e9f65235438242cb82efcd6209fce23d8af83a04b89d207"
    sha256 cellar: :any, big_sur:       "80ac873a30e9cc7d5e3240e3a50b115d18771220bd7fb42b6e44b06d223edb05"
    sha256 cellar: :any, catalina:      "356af104a4b7ec1caa894e128f926de642c1a64e1ea57a018faeb0f5d6914595"
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
