# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.25.tar.xz"
  sha256 "66fdba064aa119b1463a7969571d42f4642690275d8605ab5149bcc5107e2484"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4700cb5aab8e72da4e802691eeec54090f76f2fca386b632b304f16c696d5196"
    sha256 cellar: :any,                 arm64_ventura:  "fc364cc930ac3c30be3e8b1a567f70411f84339490f9fa13038e0b385b22f7a0"
    sha256 cellar: :any,                 arm64_monterey: "2d331b6d02c59e703a5a3554d233006cf761409679360e7866fd1e58510889e7"
    sha256 cellar: :any,                 ventura:        "5eb3c8bb6c0ccd712cfe5093e6ae6899f0c55a1ad3ef7d2e1b9e7f805bdf9bd8"
    sha256 cellar: :any,                 monterey:       "9778f7bbe29c10c31c5e5dc2050358cac18079a3afa026587ddbddf33ad590b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ad32eceb265a83d2becd5a979cdabb8119303a71046abc32d3ce569dd7355fe"
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
