# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.24.tar.xz"
  sha256 "388ee5fd111097e97bae439bff46aec4ea27f816d3f0c2cb5490a41410d44251"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d69a602e1ff9d09011afa5228d0ee9f985450fe91630c8fab7a177b83c0013aa"
    sha256 cellar: :any,                 arm64_sonoma:  "8dba7d6445cd5a96afb8557b3c28b7f431459939401540c0e64ac46dd05de219"
    sha256 cellar: :any,                 arm64_ventura: "f64406e5f9afea8e356c9bbbd326d5f7dac363a7ba90098532fa0cff5a3719cb"
    sha256 cellar: :any,                 ventura:       "845acbec808f95e361172794bbc4fbbb291890353f029e762474f83998dcf980"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0da34f9f91efec1d77305e3c5d99645141c4ae3f7b16156f9201d6653ac2021"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "947ed4e9409d5c13955e00a12827c492e8bb8a026ac8eff50367d97b72a20239"
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
