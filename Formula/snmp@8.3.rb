# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.19.tar.xz"
  sha256 "976e4077dd25bec96b5dfe8938052d243bbd838f95368a204896eff12756545f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "64f1bfe7ba11e4ad81e456edae02832594f7ccbfbdb11663d5e7cbccc655ca6a"
    sha256 cellar: :any,                 arm64_sonoma:  "a70fcc8360bcbe97f7d72a2f1ad9231d467a0ca3ef6091979501574317c122aa"
    sha256 cellar: :any,                 arm64_ventura: "e78573ed3eb7c2bf759eac19a1624e62c7142243aea8d5ded92852644dfc86e2"
    sha256 cellar: :any,                 ventura:       "6920e993f0eee709e48ad581c83700c73ac818f7b2760fc84e827744d8b66a83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c676e2379e15804ab05a4926b4566c55be34798aa455c2c7bed7684e76f036ca"
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
