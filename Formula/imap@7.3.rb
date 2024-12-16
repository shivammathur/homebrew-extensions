# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6e8642559e91f9f4321f9b8be3d4bacb1ebffb71.tar.gz"
  version "7.3.33"
  sha256 "20800afaac39c391c9d314a076160ffc9a7542149799b5688bbc029721b67cb1"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia: "afa9d9ab1996f189e615ebf2815cf818ae93848ae8a172a403731c21d258f37f"
    sha256 cellar: :any,                 arm64_sonoma:  "286ee50c6f9e817c9558550e08de9884e13b0e834e54f5bbbe4695fbbc755044"
    sha256 cellar: :any,                 arm64_ventura: "635e62cc8b3b4cf69f382ed4cbbb4427348f5a0e2615ca719e90e213fb919e55"
    sha256 cellar: :any,                 ventura:       "5e2ed4665c0c275dc10b8bc1da89653007a5167886030732593f8808ad7aa105"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1f192b9fcfca213feafc24dbaa9a9c9c849bda65334a8e5d6fa1a17970641881"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
