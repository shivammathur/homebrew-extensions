# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bc9eff539cbcaac98720ab7e8eb73dd5bdffe12c.tar.gz"
  version "7.3.33"
  sha256 "83434d34cfeb96c31010fc9e3fdd0e4f67cb3844bf2dffd760afb53270aae286"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "8abde8ff2e950bd3c35f829c3219201f94df121eb68dbe8b6a7375dee90fdca9"
    sha256 cellar: :any,                 arm64_ventura:  "b5ec6e7d3e92d82a1892026c2aada7f3d82b0e0edeaf0a7f249300647af14e01"
    sha256 cellar: :any,                 arm64_monterey: "57b8889d48f99598897931301c6d745e01b174797cee9bc1803606b81b48cea0"
    sha256 cellar: :any,                 ventura:        "89e12a6bb215477f1b86e7c3c5393bbca37e8cf4d093f0ded07f53b748bf52d8"
    sha256 cellar: :any,                 monterey:       "274f59c6d08036a11e40d061cf616367e4e89c6ccf5e0f99fb4d058eb03cdf28"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9fb3a552611e253d87f8a6e85de030b5fc1ee86c36d94422290be001df8e18d0"
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
