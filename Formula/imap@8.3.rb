# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.30.tar.xz"
  sha256 "67f084d36852daab6809561a7c8023d130ca07fc6af8fb040684dd1414934d48"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6eab8878f7f43673ce8d20f5b3831a4c574e9ebdbea28c44dd715be825de5250"
    sha256 cellar: :any,                 arm64_sonoma:  "35ac6a5fbc83dd98ec68f2b871935aaba58d44f0d185d1c427139173ce619fee"
    sha256 cellar: :any,                 sonoma:        "14b8e5d471fc9193d8bc31b980410bffe1a643a5b91ec789b13d3e67e6562e54"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb5d73dfb94ec5177cca263fa45af0de0df641073ce0b356e4049fdd21649e6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77b7d897bd16b520ca090be017102794de8ecb004b239657039526ad16b5945e"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
