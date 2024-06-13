# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.29.tar.xz"
  sha256 "288884af60581d4284baba2ace9ca6d646f72facbd3e3c2dd2acc7fe6f903536"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c931c5b349c09f85819f4845c1811d057995df7873a4af0eb9df44165ad3a888"
    sha256 cellar: :any,                 arm64_ventura:  "71c22c2564d5ce791f012c280d1f36ff2adc9cf23e6a5f2e51aff22550cd751a"
    sha256 cellar: :any,                 arm64_monterey: "e6fa4f4a8382228c405bfc31625491849f098102dff3020fe1cb945cd94c9a89"
    sha256 cellar: :any,                 ventura:        "56069790feecfa377bb1fff50091e525da8a5baba6056aa847f8b2e4dff19af9"
    sha256 cellar: :any,                 monterey:       "50b7a5375d53934c3758df71b9240c076638e42e27829f61e0bda10e1df0efb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c954ca354bb52e285e25f05623cfdefa02252e762c343f613a8973ae3b73fb07"
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
