# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/360e6f842c885f9e6018f603ba00ceb5cd78ef31.tar.gz?commit=360e6f842c885f9e6018f603ba00ceb5cd78ef31"
  version "8.3.0"
  sha256 "6ee93d0f0c4bb23a1f68a2a4e01da16f9c95fa8ab84ab6cba3e0b0cde25da371"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 28
    sha256 cellar: :any,                 arm64_monterey: "60ec057a71f1cbcacfae97e76f2ab60c0a6f3e376e8f1fca6d6f24e6c9140c86"
    sha256 cellar: :any,                 arm64_big_sur:  "43eef0176f2079aa4c2adc602ce0df56648052a1d983202a68788439294922d2"
    sha256 cellar: :any,                 monterey:       "2b9b018b716f51af909b4876253927bcf55e2ac1ac72deae65979eb213423b96"
    sha256 cellar: :any,                 big_sur:        "5e8652158fddb6049e9f64ca32c602afb2492c7cfeb667231dc7598d314a1021"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "985e1604067a50258eef9ada2849b10882c665db7f0e80537cb13f7ed24b52da"
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
