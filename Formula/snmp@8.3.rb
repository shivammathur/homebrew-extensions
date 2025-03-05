# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.17.tar.xz"
  sha256 "6158ee678e698395da13d72c7679a406d2b7554323432f14d37b60ed87d8ccfb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7b5b897a99a7a453df3dac20b4e56e8e1c0adda59d7f3ada7b4758ac1b2efef2"
    sha256 cellar: :any,                 arm64_sonoma:  "90dc6185bf6c1f50ef2329d37071373bae7b91777119a35cc1009c38db165604"
    sha256 cellar: :any,                 arm64_ventura: "a40411cf1bf477d8f24184a97f3935fb7816152e5db2d58019b7f6742c4f0dd9"
    sha256 cellar: :any,                 ventura:       "06d9d9ad81bf771ff480c11f3eb82224f8913fd9e06cc285953828cd0fbe0fa7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed7986ceb3e892433baece707b15201c3308f781ba7be60ce87f7b06f663f8e2"
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
