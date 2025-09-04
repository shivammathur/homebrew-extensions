# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.25.tar.xz"
  sha256 "187b61bb795015adacf53f8c55b44414a63777ec19a776b75fb88614506c0d37"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d604154f98be8c158a6960c1f1fbfc1faa8e769a7d41d796d4a3f14c9b7f3225"
    sha256 cellar: :any,                 arm64_sonoma:  "1705467bc734d651533316608804d01ed2f1dd463713a154c045d0e5325cb60b"
    sha256 cellar: :any,                 arm64_ventura: "be7f429a2e2f87a85abd7bcfe440174e89a354f4d34ff89063956b3ffa7f8abe"
    sha256 cellar: :any,                 ventura:       "f692c30c1998dd4d5784895c8f759b260891b12f2fde5284c2ee94c60a17755e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f1c5af1328fa4931393080d9f523e4e24f0d1b5d39fa2a50ffd7c6fd8d49d8c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "822f7903d9a2e41e81bf44da4945a1c3dec6d07f7c22993672aad168d8b83434"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
