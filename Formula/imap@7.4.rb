# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/411f97c2e0141c166142d2478f35c23d09236934.tar.gz"
  sha256 "e63a142fdb0ff2d6d1271f603f87aa40bf0f762b2bb81c21223ebdb1c04c8308"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f644a13e88236e3a67fc1f7e08fd9af35b37b30bf84c0d3bfc57ba6267335269"
    sha256 cellar: :any,                 arm64_big_sur:  "31175086d8a11874cf381bedf015d996edef0960c5f89d7a95eac7808309ff0e"
    sha256 cellar: :any,                 monterey:       "27b8d3db9f63a3e98b95941ea4b57c7913bd8bac8d6963ebd87482bcf0c08648"
    sha256 cellar: :any,                 big_sur:        "21191f622eae4534488f6cea57048f80f1859a496f202f34e24b098dc727f2c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "92c3894e47941899ea17ddabe5035cc32ff2974b0363e30e5a87d048f9b08b48"
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
