# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.16.tar.xz"
  sha256 "28cdc995b7d5421711c7044294885fcde4390c9f67504a994b4cf9bc1b5cc593"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "53f7cd32109bd7b5a54e9160a63ad238d2036a0f7e9637eb4729977cc279612b"
    sha256 cellar: :any,                 arm64_ventura:  "973b2556b8e57052d93e62e8cf581fb31b696316727425ceed671e9e2c9c9d75"
    sha256 cellar: :any,                 arm64_monterey: "d2d8c54e80511cf6923a59f633a0ac32153295c7b50991f364684288c315855f"
    sha256 cellar: :any,                 ventura:        "47aee31743112353c2e1f50fe3e859aa31f00da740c8224b1b4fa577a3e96ad0"
    sha256 cellar: :any,                 monterey:       "2d8dcc3a97a479b9692d5fc79a82ddb6c0cb5168e88ec29ba1b300c933f2b42f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "972b6af2abce47e06c98337c29b2b03c6f4e616097ea9f785e3146d67912f7f6"
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
