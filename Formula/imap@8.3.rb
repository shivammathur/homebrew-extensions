# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/91fd5641cde138b8894a48c921929b6e4abd5c97.tar.gz?commit=91fd5641cde138b8894a48c921929b6e4abd5c97"
  version "8.3.0"
  sha256 "691d6fd4c53adb5ad943b8c711a96efd67ceaef80dbafc91260eb3e4b64dcf84"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 38
    sha256 cellar: :any,                 arm64_monterey: "f052cfe8c60ed98d8ffc15a0006632249417d9ef9adcd7a1071e78cbc0e4f705"
    sha256 cellar: :any,                 arm64_big_sur:  "5799bb914859b591af092d0ab65da64011fc8b9bd2555fc113a3301ae25b8ceb"
    sha256 cellar: :any,                 ventura:        "b5b6e81534ebc28a7e0d8787392de84473d2c7564bf8f2916f74b763bffbbbb6"
    sha256 cellar: :any,                 monterey:       "da5054edb4d86551536de4b1b95b5d7ace30a68c4a78c657af0f2401543471ec"
    sha256 cellar: :any,                 big_sur:        "10832f66d426a100d548cd45649cc43042d22e275971318a93d470bc2a2d6fa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c78231f463f15c3c59ac7e605df49f71e3df5c60cf87f3f5c73e86efd9cd404e"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
