# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6dd0dcf6e1eeb3f6fcba9b3269ca0803d7bbaa2d.tar.gz"
  version "7.2.34"
  sha256 "7aadc0a75d70efb425f8d74ea9e1a4a6826d5adfaa9807ed8d034d7cef1a7aff"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f8b12adcc489e5a065c500b35ae4dad261dc0fdb6611c5130c5be230f51d5f77"
    sha256 cellar: :any,                 arm64_big_sur:  "27fdc129560dbea8cff028457dbb4a6950e83dd906e299376c1a7f959e90849b"
    sha256 cellar: :any,                 ventura:        "e687c8404a87943f0ec3ac5a4fe3b781cbab21edf8fb042c93b1b047e3ee3930"
    sha256 cellar: :any,                 monterey:       "b94d26c043b4fc4ee058c23a7ba1aebbc087c93babc0ca83e54798ad7bde8336"
    sha256 cellar: :any,                 big_sur:        "c749fbe1529ec80500028a18d38522f568a3e69b47c66d6e64d3b5d2130d30a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4048a2e708d1c0393844feadb5e7342e3458b1f435f74991de0ec0a996cf1546"
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
